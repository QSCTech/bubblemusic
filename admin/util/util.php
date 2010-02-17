<?php
	function getSID ($nSize=24) { 
		 // Randomize 
        mt_srand ((double) microtime() * 1000000);
		$sessionID = ''; 
        for ($i=1; $i<=$nSize; $i++) { 
             
            // if you wish to add numbers in your string,  
            // uncomment the two lines that are commented 
            // in the if statement 
            $nRandom = mt_rand(1,30); 
            if ($nRandom <= 10) { 
                // Uppercase letters 
                $sessionID .= chr(mt_rand(65,90)); 
         	} elseif ($nRandom <= 20) { 
                $sessionID .= mt_rand(0,9); 
            } else { 
                // Lowercase letters 
                $sessionID .= chr(mt_rand(97,122)); 
            } 
             
        }         
        return $sessionID; 
    } 
	
 	function is_utf8($string) {
		// From http://w3.org/International/questions/qa-forms-utf-8.html
		return preg_match('%^(?:
		[\x09\x0A\x0D\x20-\x7E] # ASCII
		| [\xC2-\xDF][\x80-\xBF] # non-overlong 2-byte
		| \xE0[\xA0-\xBF][\x80-\xBF] # excluding overlongs
		| [\xE1-\xEC\xEE\xEF][\x80-\xBF]{2} # straight 3-byte
		| \xED[\x80-\x9F][\x80-\xBF] # excluding surrogates
		| \xF0[\x90-\xBF][\x80-\xBF]{2} # planes 1-3
		| [\xF1-\xF3][\x80-\xBF]{3} # planes 4-15
		| \xF4[\x80-\x8F][\x80-\xBF]{2} # plane 16
		)*$%xs', $string);
		
	} // function is_utf8
	
	function copy_cover($dir, $file_name, $target){
		if (!is_dir($dir)) {
	        return;
	    }
	    if ($dh = opendir($dir)) {
	        while (($file = readdir($dh)) !== false) {
	            if ($file[0] === '.') {
	                continue;
	            }
	            $path = $dir . '/' . $file;
	            if (is_dir($path)) {
	                copy_cover($path, $file_name, $target);
	            } else {
	                if ($file == $file_name) {
	                    rename($path, $target);
	                }
	            }
	        }
	        closedir($dh);
   		 }
	}
	
	function get_path4music_id($music_id){
		$music = db_music_get_music4music_id($music_id);
	
		$yearMonth = substr($music["upload_date"], 0, 7);
		$music_name = $music["music_name"];
		$album_name = $music["album_name"];
		$artists_name = $music["artists_name"];
		
		$file = array();
		$file["mp3"] = SOURCE.$yearMonth."/$artists_name - $album_name/$music_name.mp3";
		$file["lrc"] = SOURCE.$yearMonth."/$artists_name - $album_name/$music_name.lrc";
		return $file;
	}
?>