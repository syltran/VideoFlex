<?php
$nb_note = $cnx->query("SELECT count(note) FROM note WHERE id_profil = $id_profil AND titre_vid = '$titre_vid'");
$lig = $nb_note->fetch();

$note = $cnx->query("SELECT note FROM note WHERE id_profil = $id_profil AND titre_vid = '$titre_vid'");
$val = $note->fetch();

if($lig["count"] >= 1){
    echo "Votre note : ".$val["note"];
}
?>



<form action="video.php" method="post">
    <p>
    <input type="submit" name="evaluer" value="Evaluer"/>
    </p>
</form>



<?php
if (isset($_POST["evaluer"])){

    if($lig["count"] >= 1){
        echo "Vous avez déjà notez";
    }
    else{
        require("form_attr_note.php"); //acceder au formulaire pour noter la video
    }
}
?>

<?php
if (!empty($_POST["note"]) && isset($_POST["valider"])){
    $note = $_POST["note"];

    if (0 <= $note && $note <= 10){
        $prep = $cnx->prepare("INSERT INTO note VALUES (:idp, :titre, :note)");
        $exec = $prep->execute(array(':idp' => $id_profil, ':titre' => $titre_vid, ":note" => $note));
        header("location: video.php");
        die();
    }
    else{
        echo "Votre note doit être en 0 et 10";
    }
}

?>