<form action="compte.php" method="post">
    <p>
    <?php
    require("connexion.inc.php");

    $tab = $cnx->query("SELECT * FROM profil");

    while ($lig = $tab->fetch()){
        if ($lig["id_compte"] == $id_compte){
            echo "<button type='submit' name='id_profil' value=".$lig["id_profil"].">".$lig["nom"]."</button>";
            echo "<br/>";
        }
    }
    ?>
	</p>
</form>


<?php
if (!empty($_POST["id_profil"])){
    $_SESSION["id_profil"] = $_POST["id_profil"];
    header("location: profil.php");
}

?>