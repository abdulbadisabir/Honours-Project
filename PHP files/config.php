<?php
    
    return array(
                 'host' => "localhost",
                 'username' => "root",
                 'password' => "LetsGo",
                 'dbname' => "LetsGo",
                 'dbstorage' => "EventStorage"
                 
                 
                 );
  
  
    
    class userinfo {
        public $id;
        public $username;
        public $password;
        public $firstname;
        public $lastname;
        public $gender;
        public $age;
        public $email;
        public $birthday;
        public $rating;
        public $eventsattended;
        public $eventsrsvped;
        public $photopath;
         public function __construct ($ui) {
             $this->id = $ui["id"];
             $this->username = $ui["username"];
             $this->password = $ui["password"];
             $this->firstname = $ui["firstname"];
             $this->lastname = $ui["lastname"];
             $this->gender = $ui["gender"];
             $this->age = $ui["age"];
             $this->email = $ui["email"];
             $this->birthday = $ui["birthday"];
             $this->rating = $ui["rating"];
             $this->eventsattended = $ui["eventsattended"];
             $this->eventsrsvped = $ui["eventsrsvped"];
             $this->photopath = $ui["photopath"];
             
             
         }
        
        //Helper function to quickly convert empty strings "" to NULL values, and non-NULL values into strings that can be entered into sql without having to use single quotes (very difficult to send a NULL value from php to mysql).
        public function quicknull($v) {
          
           $v ?  (addcslashes($v,'"') and  $v = "'" . $v . "'") : $v ='null';
            return $v;
            
        }
      
        
        public function sql() { //Change data into easy to input sql format. 
            foreach($this as $key=>&$value) {
                
                $value = $this->quicknull($value);
                
            }
            
            
            
            
            
            
            
        }
    }
    
    class eventinfo {
        public $id;
        public $Owner;
        public $StartTime;
        public $EndTime;
        public $Title;
        public $Description;
        public $Male;
        public $Female;
        public $LeastAge;
        public $MaxAge;
        public $Address;
        public $longitude;
        public $lattitude;
        public $Duration;
        public $photopath;
       
        
        public function __construct ($ei) {
            foreach($this as $key=>&$value) {
                $value = $ei["$key"];
                
            }
            
        }
        
        //Helper
        public function quicknull($v) {
            
            $v ?  ($v = addcslashes($v,'"') and  $v = "'" . $v . "'") : (is_bool($v) ? $v = 0 : $v ='null');
            return $v;
            
        }
        
        
        public function sql() { //Change data into easy to input sql format.
            foreach($this as $key=>&$value) {
               
                $value = $this->quicknull($value);
                
            }
            
        }
    }
?>
