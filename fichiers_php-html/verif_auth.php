<?php
require("connexion.inc.php");

if (!empty($_POST["mail"]) && !empty($_POST["mdp"])){

    $mail = $_POST["mail"];
    $mdp = $_POST["mdp"];

    $_SESSION["mail"] = $mail;
    $_SESSION["mdp"] = $mdp;


    $tab = $cnx->query("SELECT * FROM compte");
    while ($lig = $tab->fetch()){
        if ($lig["courriel"] == $mail && $lig["mdp"] == md5($mdp)){
            /*Authentification réussie*/

            /*Je recup toutes les infos du compte associé à l'adresse mail entrée*/
            $_SESSION["id_compte"] = $lig["id_compte"];
            $_SESSION["nom"] = $lig["nom"];
            $_SESSION["prenom"] = $lig["prenom"];
            $_SESSION["adresse"] = $lig["adresse"];
            $_SESSION["type_abo"] = $lig["type_abo"];
            $_SESSION["datefin_abo"] = $lig["datefin_abo"];

            header("location: compte.php");
            die();
        }
        elseif ($lig["courriel"] == $mail && $lig["mdp"] != md5($mdp)){
            die("Mot de passe incorrect");
            
        }
    }
    echo "Cette adresse e-mail n'exite pas";
}
?>