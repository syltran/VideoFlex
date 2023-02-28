<?php
require("connexion.inc.php");
?>


<form action="inscription.php" method="post">
	<p>
        Nom* :<input type="text" name="nom" size="12"/> <br/>
		Prénom* :<input type="text" name="prenom" size="12"/> <br/>
		Adresse* :<input type="text" name="adresse" size="25"/> <br/>
		E-mail* :<input type="text" name="mail" size="25" placeholder="Exemple : toto@gmail.com"/> <br/>
		Mot de passe* :<input type="password" name="mdp" maxlength="16" size="25" placeholder="16 caractères maximum"/> <br/>
	</p>
	<p>
		Type d'abonnement* : <br/>
		<input type="radio" name="type" value="0"/>Normal<br/>
		<input type="radio" name="type" value="1"/>Premium<br/>
	</p>

	<p>
		<input type="reset" value="Effacez" /> 
		<input type="submit" name="submit" value="Validez" />
	</p>
	<p><small>* Champs obligatoire</small></p>
</form>



<?php
function verif_mail($mail){
	$cond = strpos($mail, '@gmail.com');
	if ($cond == false){
		return False;
	}
	return True;
}

function exist_mail($mail){
	require("connexion.inc.php");
	
	$tab = $cnx->query("SELECT courriel FROM compte");
	while ($lig = $tab->fetch()){
		if ($lig["courriel"] == $mail){
			return False;
		}
	}
	return True;
}
?>



<?php
if (isset($_POST["submit"]) && !empty($_POST["nom"]) && !empty($_POST["prenom"]) && !empty($_POST["adresse"]) && !empty($_POST["mail"]) && !empty($_POST["mdp"]) && isset($_POST["type"])){

	$nom = $_POST["nom"];
	$prenom = $_POST["prenom"];
	$adresse = $_POST["adresse"];
	$mail = $_POST["mail"];
	$mdp = $_POST["mdp"];
	$t_abo = $_POST["type"];

	//on verifie si l'adresse mail entrée est valide
	if (verif_mail($mail) == false){
		die("Adresse e-mail invalide");
	}

	//on verifie si l'adresse mail n'existe pas déjà
	if (exist_mail($mail) == false){
		die("Cette adresse e-mail existe déjà");
	}

	$last_id = $cnx->query("SELECT max(id_compte) FROM compte");
    $val = $last_id->fetch();

	//date de fin d'abonnement => 1 ans après
	$annee  = mktime(0, 0, 0, date("m"),   date("d"),   date("Y")+1);
	$d_abo = date("Y-m-d", $annee);

	$prep = $cnx->prepare("INSERT INTO compte VALUES (:idc, :n, :p, :a, :mail, :mdp, :t_abo, :d_abo)");
	$exec = $prep->execute(array(':idc' => $val["max"]+1, ':n' => $nom, ':p' => $prenom, ':a' => $adresse, ':mail' => $mail, ':mdp' => md5($mdp), ':t_abo' => $t_abo, ':d_abo' => $d_abo));
	if ($exec){
		echo "Votre inscription est un succès";
		require("form_apres_insc.php"); //form pour retourner à la page d'accueil ou s'identifier
	}
	die();
}
else if (isset($_POST["submit"])){
	echo "Veuillez remplir tout le formulaire";
}
?>



<?php
if (isset($_POST["accueil"])){
	header("location: accueil.php");
	die();
}
else if (isset($_POST["identifier"])){
	header("location: auth.php");
	die();
}

?>
