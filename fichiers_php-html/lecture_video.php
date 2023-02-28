
<?php
if (isset($_POST["lecture"])){
    require("connexion.inc.php");

    $text = $_POST["lecture"];

    if ($text == "Reprendre"){
        $duree = $cnx->query("SELECT duree FROM visionnage WHERE id_profil = $id_profil AND titre_vid = '$titre_vid'");
        $val = $duree->fetch();
        echo"
        <video width='500' height='500' controls>
            <source src='video.mp4#t=".$val["duree"]."' type='video/mp4'>
            La video ne peut pas être lu
        </video>
        ";
    }
    else{
        echo "
        <video width='500' height='500' controls>
            <source src='video.mp4' type='video/mp4'>
            La video ne peut pas être lu
        </video>
        ";
    }
}
?>