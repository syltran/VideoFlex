
<form action="compte.php" method="post">
    <p>
    <input type="submit" name="info" value="Information sur le compte"/>
    </p>
</form>



<?php
if (isset($_POST["info"])){
    echo "Nom : $nom <br/>";
    echo "Prénom : $prenom <br/>";
    echo "Adresse : $adresse <br/>";
    echo "Adresse e-mail : $mail <br/>";

    if ($type_abo == 0){
        echo "Compte Normal";
    }
    else{
        echo "Compte premium";
    }
    echo "<br/>";

    $date = explode("-", $datefin_abo);
    echo "Votre abonnement prendra fin le : ".$date[2]."/".$date[1]."/".$date[0];

    echo"
    <form action='compte.php' method='post'>
    <p>
    <input type='submit' value='Fermer'/>
    </p>
    </form>
    ";
}

?>