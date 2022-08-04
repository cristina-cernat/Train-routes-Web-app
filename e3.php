<?php

    $status=$_GET['status'];
	$mysql = new mysqli ('localhost', 'root', '', 'students' );
	$myquery = "select link from cat_photos where code=".$status;
	$res=$mysql->query($myquery);
	while ($inreg = $res->fetch_assoc()) {
	foreach ($inreg as $coloana)
	$jsonfile = "[\"" . $coloana . "\"]";
	}
	//echo $jsonfile;
	$jsonfile = json_decode($jsonfile,true);
	//echo $jsonfile;
	//echo "<img src='".$jsonfile[0]."'></img>";
	return $jsonfile;
?>