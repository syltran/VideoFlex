<form action="compte.php" method="post">
    <p>Nom du profil: <input type="text" name="nom" size="12"/><br/>
	<p>
		<input type="submit" name="submit" value="Ajouter" />
		<input type="submit" name="submit" value="Supprimer" />
	</p>
</form>



<?php
require("connexion.inc.php");

if (!empty($_POST["nom"])){

    $nom = $_POST["nom"];
    $action = $_POST["submit"]; //ajouter ou supprimer


    $tab2 = $cnx->query("SELECT * FROM profil");
    $nbprofil = $cnx->query("SELECT count(id_compte) FROM profil WHERE id_compte = $id_compte");

    if ($action == "Ajouter"){
        if ($type_abo == 1 && $nbprofil->fetch()["count"] >= 4){
            die("Vous possédez déjà 4 profils");
        }
        else if ($type_abo == 0 && $nbprofil->fetch()["count"] >= 1){
            echo "Impossible d'ajouter un 2ème profil <br/>";
            echo "Passer Premium pour pouvoir utiliser jusqu'à 4 profils";
            die();
        }

        while ($lig2 = $tab2->fetch()){
            if ($lig2["id_compte"] == $id_compte){
                if($lig2["nom"] == $nom){
                    die("Vous avez déjà utilisé ce nom");
                }
            }
        }
        $last_id = $cnx->query("SELECT max(id_profil) FROM profil");
        $val = $last_id->fetch();

        $prep = $cnx->prepare("INSERT INTO profil VALUES (:idp, :nom, :idc)");
        $exec = $prep->execute(array(':idp' => $val["max"]+1, ':nom' => $nom, ":idc" => $id_compte));
        if ($exec){
            //echo "Le profil $nom a été ajouté";
            header("location: compte.php");
        }
        die();

    }
    else{ //suppr
        while ($lig2 = $tab2->fetch()){
            if ($lig2["id_compte"] == $id_compte){
                if($lig2["nom"] == $nom){
                    $prep = $cnx->prepare("DELETE FROM profil WHERE nom = :n AND id_compte = :i");
                    $exec = $prep->execute(array(':n' => $nom, ':i' => $id_compte));
                    if ($exec){
                        //echo "Le profil $nom a été supprimé";
                        header("location: compte.php");
                    }
                    die();
                }
            }
        }
        die("Le profil $nom n'existe pas");
    }

}
?>