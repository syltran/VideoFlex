<form action="profil.php" method="post">
    <p>Search:
        <input type="text" name="recherche_ser_film" size="27" placeholder="Recherchez une série ou un film"/> 
        <input type="submit" value="Valider"/>
    </p>
</form>



<?php
require("connexion.inc.php");

if (!empty($_POST["recherche_ser_film"])){

    $search = $_POST["recherche_ser_film"];

    $tab = $cnx->query("SELECT titre_vid, titre_ser FROM video");
    while($lig = $tab->fetch()){
        if ($lig["titre_vid"] == $search){ //Film

            $_SESSION["titre_vid"] = $search;
            header("location: video.php");
        }
        else if ($lig["titre_ser"] == $search){ //Serie

            $_SESSION["titre_ser"] = $search;
            header("location: serie.php");
        }
    }
    echo "Aucun résultat pour $search";
}

?>