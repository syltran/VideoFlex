<form action="profil.php" method="post">
<?php
require("connexion.inc.php");


$video = $cnx->query("SELECT * FROM bestfilms");
$cmpt = 1;

echo "TOP des films : ";
while($lig = $video->fetch()){
    echo "<p>$cmpt.";
    echo $lig["films"];
    echo "<br/>";
    echo "<button type='submit' name='top' value='".$lig["films"]."'>Visionner</button>";
    echo "</p>";
    $cmpt +=1;
}
?>
</form>


<?php
if (isset($_POST["top"])){
    $_SESSION["titre_vid"] = $_POST["top"];
    header("location: video.php");
}

?>