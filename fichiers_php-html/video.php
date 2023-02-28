<?php
session_start();

$titre_vid = $_SESSION["titre_vid"];
$id_profil = $_SESSION["id_profil"];

$action = "profil.php";
if (isset($_SESSION["back"])){
    $action = $_SESSION["back"];
    unset($_SESSION["back"]);
}
?>

<!DOCTYPE html>
<html lang=fr>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>
        <?php
        echo $titre_vid;
        ?>
	</title>

	<style>
		body {
			background-color:#ffd;
			font-family:Verdana,Helvetica,Arial,sans-serif;
		}
	</style>
</head>

<body>
    <?php
    echo "<form action='".$action."' method='post'>"
    ?>
        <input type="submit" name="back" value="retour"/>
    </form>

    <p>
    <?php
    echo "<h2>".$titre_vid."</h2>";
    require("info_video.php");
    ?>
    </p>

    <p>
    <?php
    require("redirige_lecture.php");
    ?>
    </p>

    <p>
    <?php
    require("note.php");
    ?>
    </p>

    <p>
    <?php
    require("label.php");
    ?>
    </p>

</body>
</html>
