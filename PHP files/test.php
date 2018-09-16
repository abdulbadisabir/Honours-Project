<?php
   // phpinfo();
   // $obj = json_decode(file_get_contents('php://input'),TRUE);
    $configs = include('config.php');
   
    
    $servername = $configs["host"];
    $username = $configs["username"];
    $password = $configs["password"];
    $dbname = $configs["dbname"];
    
    
    //$ui = new userinfo();
    
    
    $conn = mysql_connect($servername, $username, $password);
    mysql_select_db($dbname);
    if(! $conn ) {
        die('Could not connect: ' . mysql_error());
    }
    $_POST = json_decode(file_get_contents('php://input'), true);
    $ui = new userinfo($_POST);
    //$ui->firstname = userinfo($_POST);
    
    //$j = 'NULL';
   // $t = "$j";
    
    //$r = '';
    //addcslashes($r,'"');
    //$r = "'" . $r . "'";
   // $j = $r;
    $ui->sql();
   
    if ($conn->connect_error) {
         echo "IT DIDNT WORKED1!!";
        die("Connection failed: " . $conn->connect_error);
        
        
        
    }else
    {
        
        $sql = "INSERT INTO users (firstname,lastname,username,birth,password,eventsattended,eventsrsvped,gender,email) values ($ui->firstname, $ui->lastname, $ui->username, $ui->birthday, $ui->password, $ui->eventsattended, $ui->eventsrsvped, $ui->gender, $ui->email); ";
        
     
       // echo $ui->rating;
        
        //echo (isset(ui->rating));
        //$sql = "INSERT INTO users (username,password) VALUES ('hihihi','bbb')";
       //$sql = "UPDATE users SET lastname = $j where username = 'helo';";
      // $sql = "UPDATE users SET test = 10 where username = 'helo' and lastname is null;";
        $retval = mysql_query( $sql, $conn );
        
        if(! $retval ) {
            die('Could not get data: ' . mysql_error());
        }
        
       
     
       
      
      
        //echo $lol;
        //echo $ui->email;
        //echo $j;
        //echo "hello";
        //echo $_POST[0];
    }
    
    
    
    /*
    $sql = "SELECT name FROM userinfo WHERE id=1";
    $result = $conn->query($sql);
    
    echo $result->name;
    
   
    
    if($conn->query($sql) == TRUE){
        echo "it worked and ";
        echo $result;
    }else
    {
        echo "it didn't work";
    }*/
    
    
    
    
    
    
    
    ?>
