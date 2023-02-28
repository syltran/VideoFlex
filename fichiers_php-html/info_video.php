<?php
if (isset($_POST["titre_ser"])){
    $_SESSION["titre_ser"] = $_POST["titre_ser"];
    $_SESSION["back"] = "video.php";
    header("location: serie.php");
}
?>


<?php
require("connexion.inc.php");

$info = $cnx->query("SELECT * FROM video WHERE titre_vid = '$titre_vid'");
$realisateur = $cnx->query("SELECT nom, prenom FROM video NATURAL JOIN personne WHERE titre_vid = '$titre_vid'");
$acteurs = $cnx->query("SELECT nom, prenom FROM joue NATURAL JOIN personne WHERE titre_vid = '$titre_vid'");
$nb_act = $cnx->query("SELECT count(id_personne) FROM joue WHERE titre_vid = '$titre_vid'");

$lig = $info->fetch();
echo $lig["annee_prod"]."<br/>";
echo $lig["duree"]."<br/>";


//si c'est un épisode d'une série
$episodes = $cnx->query("SELECT * FROM video WHERE titre_ser IS NOT NULL");
while ($ep = $episodes->fetch()){
    if ($ep["titre_vid"] == $titre_vid){
        
        echo "
        <form action='video.php' method='post'>
            Serie : <input type='submit' name='titre_ser' value='".$ep["titre_ser"]."' />
        </form>
        ";

        //echo "Serie : ".$ep["titre_ser"]."<br/>";
        echo "Saison : ".$ep["saison"]."<br/>";
        echo "Episode : ".$ep["episode"]."<br/>";
    }
}


$lig2 = $realisateur->fetch();
echo "Réalisateur : ".$lig2["nom"]." ".$lig2["prenom"]."<br/>";


$cmpt = 0;
$nbr = $nb_act->fetch()["count"];

echo "Avec : ";
while ($pers = $acteurs->fetch()){
    echo $pers["nom"]." ".$pers["prenom"];
    $cmpt +=1;

    if ($cmpt < $nbr){
        echo ", ";
    }
}


?>