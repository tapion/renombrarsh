<?php
$con = mysql_connect("localhost", "root", 'Admin$_my2012%') or die("Error en la conexión con el servidor");
mysql_select_db("californ_californiaed", $con) or die("Error selecionando la Báse de datos");
//$con = mysql_connect("localhost", "root", "123456") or die("Error en la conexión con el servidor");
//mysql_select_db("california", $con) or die("Error selecionando la Báse de datos");

$sql = "SELECT pur.item_id,pur.link_title,pur.link_file,sa.customer_firstname,sa.customer_lastname,sa.customer_email,cor.value,SUBSTRING_INDEX(pur.link_file, '/', -1) as archivo,SUBSTRING(pur.link_file, 2, 1) as uno,SUBSTRING(pur.link_file, 4, 1) as dos FROM `downloadable_link_purchased_item` pur
inner join sales_flat_order sa on sa.entity_id = pur.`order_item_id` 
inner join core_config_data cor
WHERE pur.status = 'available' and pur.modificadoEpub = 'No' and cor.config_id = 3";

$result = mysql_query($sql, $con);
while($row = mysql_fetch_array($result)){
    exec("./marcalibros.sh '{$row["archivo"]}' '{$row["customer_firstname"]} {$row["customer_lastname"]}' '{$row["customer_email"]}' '{$row["uno"]}' '{$row["dos"]}' 2>&1", $salida, $prueba);
    if($salida[0] == "ok"){
        $sql = "update downloadable_link_purchased_item set modificadoEpub = 'Si', link_file = '/{$row["uno"]}/{$row["dos"]}/{$salida[1]}',fechaModificadoEpub = now() where item_id = '{$row["item_id"]}'";
        mysql_query($sql);
        //echo $sql."<br/>";
    }
}
?>
