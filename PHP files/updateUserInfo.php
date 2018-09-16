<?php
   // phpinfo();
   // $obj = json_decode(file_get_contents('php://input'),TRUE);
    $configs = include('config.php');
   
    
    $servername = $configs["host"];
    $username = $configs["username"];
    $password = $configs["password"];
    $dbname = $configs["dbname"];
    
    
  
    
    
    $conn = mysql_connect($servername, $username, $password);
    mysql_select_db($dbname);
    if(! $conn ) {
        die('Could not connect: ' . mysql_error());
    }
  
    $_POST = json_decode(file_get_contents('php://input'), true);
    $_POST["eventsattended"] ? $evatd = $_POST["eventsattended"] : $evatd = 0;
    $_POST["eventsrsvped"] ? $evrsvpd = $_POST["eventsrsvped"] : $evrsvpd = 0 ;
    echo "RSVPED  " . "$evrsvpd";
    $ui = new userinfo($_POST);
   
    $ui->sql();
   
    if ($conn->connect_error) {
         echo "IT DIDNT WORKED1!!";
        die("Connection failed: " . $conn->connect_error);
        
        
        
    }else
    {
        
        $sql = "UPDATE users SET  firstname=$ui->firstname, lastname=$ui->lastname, birthday=str_to_date($ui->birthday, '%Y-%m-%dT%TZ'), password=$ui->password, eventsattended=$evatd, eventsrsvped=$evrsvpd, gender=$ui->gender, email=$ui->email WHERE username= $ui->username; ";
        
    
        $retval = mysql_query( $sql, $conn );
        
        if(! $retval ) {
            die('Could not get data: ' . mysql_error());
        }
        
       
     
       
      
  
    }
    
    
    
   
    
    
    
    
    
    
    
    ?>
