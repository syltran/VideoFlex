
<form action="profil.php" method="post">
<?php
require("connexion.inc.php");

//$tab = $cnx->query("SELECT * FROM visionnage");
$video = $cnx->query("SELECT titre_vid FROM visionnage WHERE id_profil = $id_profil AND fin = 0");

while($lig = $video->fetch()){
    echo "<p>";
    echo $lig["titre_vid"];
    echo "<br/>";
    echo "<button type='submit' name='en_cours' value='".$lig["titre_vid"]."'>Reprendre</button>";
    echo "</p>";
}
?>
</form>


<?php
if (isset($_POST["en_cours"])){
    $_SESSION["titre_vid"] = $_POST["en_cours"];
    header("location: video.php");
}

?>