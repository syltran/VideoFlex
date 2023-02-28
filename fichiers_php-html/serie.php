<?php
session_start();

$titre_ser = $_SESSION["titre_ser"];

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
		echo $titre_ser;
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

    <?php
    echo "<h3>$titre_ser</h3>";
    ?>

	<p>
	<?php
	require("info_serie.php");
	?>
	</p>

</body>
</html>



