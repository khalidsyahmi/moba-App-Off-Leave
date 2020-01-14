<?php
header("Access-Control-Allow-Origin: *");

   // Define database connection parameters
   $hn      = 'localhost';
   $un      = 'root';
   $pwd     = '';
   $db      = 'permohonancuti';
   $cs      = 'utf8';

   // Set up the PDO parameters
   $dsn 	= "mysql:host=" . $hn . ";port=3306;dbname=" . $db . ";charset=" . $cs;
   $opt 	= array(
                        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ,
                        PDO::ATTR_EMULATE_PREPARES   => false,
                       );
   // Create a PDO instance (connect to the database)
   $pdo 	= new PDO($dsn, $un, $pwd, $opt);
   $data    = array();
   $key     = $_GET['key'];

if(isset($_GET['id'])) {
	 $id = $_GET['id'];
   }
   
   // Determine which mode is being requested
   switch($key)
   {
      // Request data from cutiseparuhhari table
      case "listMaster":
	  
   // Attempt to query database table and retrieve data
   try {
      $stmt 	= $pdo->query('SELECT * FROM cutiseparuhhari');
      while($row  = $stmt->fetch(PDO::FETCH_OBJ))
      {
         // Assign each row of data to associative array
         $data[] = $row;
      }

      // Return data as JSON
      echo json_encode($data);
   }
   catch(PDOException $e)
   {
      echo $e->getMessage();
   }

break;

// Request data from cutiseparuhhari table
      case "detailcuti":
	  
   // Attempt to query database table and retrieve data
   try {
      $stmt 	= $pdo->prepare('SELECT * FROM cutiseparuhhari WHERE id=?');
	  $stmt->execute([$id]);
      while($row  = $stmt->fetch(PDO::FETCH_OBJ))
      {
         // Assign each row of data to associative array
         $data[] = $row;
      }

      // Return data as JSON
      echo json_encode($data);
   }
   catch(PDOException $e)
   {
      echo $e->getMessage();
   }

break;
		
		// Request data from taskdistr table
      case "listProjectPlan":


		// Attempt to query database table and retrieve data
		try {
			$stmt 	= $pdo->query('SELECT * FROM cutiseparuhhari');
			while($row  = $stmt->fetch(PDO::FETCH_OBJ))
			{
				// Assign each row of data to associative array
				$data[] = $row;
			}

			// Return data as JSON
			echo json_encode($data);
		}
		catch(PDOException $e)
		{
			echo $e->getMessage();
		}
   
		break;
		
		// Request data from taskdistr table
      case "listTaskTarget":


		// Attempt to query database table and retrieve data
		try {
			$stmt 	= $pdo->prepare('SELECT section FROM cutiseparuhhari WHERE projectID = ?');
			$stmt->execute([$projectID]); 
			while($row  = $stmt->fetch(PDO::FETCH_OBJ))
			{
				// Assign each row of data to associative array
				$data[] = $row;
			}

			// Return data as JSON
			echo json_encode($data);
		}
		catch(PDOException $e)
		{
			echo $e->getMessage();
		}
   
		break;
   }

?>