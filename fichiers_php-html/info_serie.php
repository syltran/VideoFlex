
<form action="serie.php" method="post">
    <p>
    <?php
    require("connexion.inc.php");

    $saisons = $cnx->query("SELECT DISTINCT saison FROM video WHERE titre_ser = '$titre_ser'");

    while ($s = $saisons->fetch()){
        echo "<p>Saison ".$s["saison"]."</p>";

        $info = $cnx->query("SELECT * FROM video WHERE titre_ser = '$titre_ser'");
        while($lig = $info->fetch()){
            if ($lig["saison"] == $s["saison"]){
                echo "episode ".$lig["episode"]." :";
                echo "<button type='submit' name='titre_vid' value='".$lig["titre_vid"]."'>".$lig["titre_vid"]."</button>";
                echo "<br/>";
            }
        }
        $info->closeCursor();
    }
    ?>
    </p>
</form>


<?php
if (!empty($_POST["titre_vid"])){
    $_SESSION["titre_vid"] = $_POST["titre_vid"];
    $_SESSION["back"] = "serie.php";
    header("location: video.php");
}

?>