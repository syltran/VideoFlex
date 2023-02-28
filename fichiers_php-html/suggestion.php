
<form action="profil.php" method="post">
<?php
require("connexion.inc.php");

//label le plus fréquent
$label = $cnx->query("SELECT nom, count(nom) FROM attribue WHERE id_profil = $id_profil GROUP BY nom ORDER BY count(nom) DESC LIMIT 1");
$val = $label->fetch();

//on recup les films et séries qui possède le même label 
$serie = $cnx->query("SELECT DISTINCT titre_ser FROM attribue NATURAL JOIN video WHERE id_profil <> $id_profil AND nom = '".$val["nom"]."'"." AND titre_ser IS NOT NULL");
$film = $cnx->query("SELECT titre_vid FROM attribue NATURAL JOIN video WHERE id_profil <> $id_profil AND nom = '".$val["nom"]."'"." AND titre_ser IS NULL");


$tabS = $serie->fetchAll();
$tabF = $film->fetchAll();
$nbrS = sizeof($tabS);
$nbrF = sizeof($tabF);

$total = $nbrS + $nbrF;
if ($total == 1){
    echo "Suggestion : ";
}
else if ($total > 1){
    echo "Suggestions : ";
}




//$lig = $serie->fetch()
foreach($tabS as $cle => $lig){
    echo "<p>";
    echo $lig["titre_ser"];
    echo "<br/>";
    echo "<button type='submit' name='sugg_ser' value='".$lig["titre_ser"]."'>Visionner</button>";
    echo "</p>";
}

//$lig = $film->fetch()
foreach($tabF as $cle => $lig){
    echo "<p>";
    echo $lig["titre_vid"];
    echo "<br/>";
    echo "<button type='submit' name='sugg_film' value='".$lig["titre_vid"]."'>Visionner</button>";
    echo "</p>";
}

?>
</form>


<?php
if (isset($_POST["sugg_ser"])){
    $_SESSION["titre_ser"] = $_POST["sugg_ser"];
    header("location: serie.php");
}
else if (isset($_POST["sugg_film"])){
    $_SESSION["titre_vid"] = $_POST["sugg_film"];
    header("location: video.php");
}

?>