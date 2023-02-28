<?php
$nb_label = $cnx->query("SELECT count(nom) FROM attribue WHERE id_profil = $id_profil AND titre_vid = '$titre_vid'");
$lig = $nb_label->fetch();

$labels = $cnx->query("SELECT nom FROM attribue WHERE id_profil = $id_profil AND titre_vid = '$titre_vid'");

if($lig["count"] >= 1){
    if ($lig["count"] == 1){
        echo "Label attribué : ";
    }
    else{
        echo "Labels attribués : ";
    }

    $cmpt = 0;
    while ($nom = $labels->fetch()){
        echo $nom["nom"];
        $cmpt +=1;
    
        if ($cmpt < $lig["count"]){
            echo ", ";
        }
    }
}
?>



<form action="video.php" method="post">
    <p>
    <input type="submit" name="attribuer" value="Attribuer un Label"/>
    </p>
</form>



<?php
if (isset($_POST["attribuer"])){
    require("form_attr_label.php"); //acceder au formulaire pour ajouter un label
}
?>

<?php
if (!empty($_POST["label"]) && isset($_POST["valider"])){
    $label = $_POST["label"];

    $prep = $cnx->prepare("INSERT INTO attribue VALUES (:idp, :nom, :titre)");
    $exec = $prep->execute(array(':idp' => $id_profil, ':nom' => $label, ':titre' => $titre_vid));
    header("location: video.php");
    die();
}
?>