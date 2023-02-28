
<?php
require("connexion.inc.php");
$text = "Visionner";

$video = $cnx->query("SELECT titre_vid FROM visionnage WHERE id_profil = $id_profil AND fin = 0");
while ($lig = $video->fetch()){
    if ($lig["titre_vid"] == $titre_vid){
        $text = "Reprendre";
    }
}
?>


<form action="lecture.php" method="post">
    <p>
    <?php
    echo "<input type='submit' name='lecture' value=".$text." />"
    ?>
    </p>
</form>
