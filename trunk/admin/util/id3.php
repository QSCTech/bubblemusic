<?php

// Because ID3v2 is so free from things are in arrays. Start with
// print_r($id3->id3v2tag) or read the source. I don't expect the output
// to be useful but I would like to know if it barfs hard on any of your
// mp3s. Oh yea, it currently only looks that the begining of the file for
// an ID3v2 tag and don't get too comfortable with this version I'll probably
// change the array structures once I get a better grasp of this stuff.

define('ID3_AUTO_STUDY', true);

// define('ID3_SHOW_DEBUG', true);

class id3 {
    /*
     * To use this code first create a id3 object passing the path to the mp3 as the first
     * parameter. Then just access the ID3 fields directly (look below for their names).
     * If you want to update a tag just change the fields and then $id3->write();
     * The methods designed for general use are study(), write(), copy($from), remove(),
     * and genres(). Please read the comment before each method for the specifics of each.
     * 
     * eg:
     *     require_once('class.id3.php');
     *    $id3 = new id3('/path/to/our lady peace - middle of yesterday.mp3');
     *  echo $id3->artists, ' - ', $id3->name;
     *    $id3->comment = 'Go buy some OLP CDs, they rock!';
     *    $id3->write();
     *
     */

    var $_version = 1.31;    // Version of the id3 class (float, not major/minor)


    var $file = false;        // mp3/mpeg file name (you should never modify this)

    var $id3v1 = false;        // ID3 v1 tag found? (also true if v1.1 found)
    var $id3v11 = false;    // ID3 v1.1 tag found?
    var $id3v2 = false;        // ID3 v2 tag found? (not used yet)

    // ID3v1.1 Fields:
    var $name = '';        // track name
    var $artists = '';        // artists
    var $album = '';        // album
    var $year = '';        // year
    var $comment = '';        // comment
    var $track = 0;        // track number
    var $genre = '';        // genre name
    var $genreno = 255;        // genre number

    // ID3v2:
    var $id3v2tag = false;    // ID3v2 Tag, use print_r to figure this out.

    // MP3 Frame Stuff
    var $studied = false;    // Was the file studied to learn more info?
    var $mpeg_ver = false;    // version of mpeg
    var $layer = false;        // version of layer
    var $bitrate = false;    // bitrate
    var $crc = false;        // Frames are crc protected?
    var $frequency = 0;        // Frequency
    var $padding = false;    // Frames padded
    var $private = false;    // Private bit set?
    var $mode = '';        // Mode (Stereo etc)
    var $copyright = false;    // Copyrighted?
    var $original = false;    // On Original Media? (never used)
    var $emphasis = '';        // Emphasis (also never used)
    var $filesize = -1;        // Bytes in file
    var $frameoffset = -1;    // Byte at which the first mpeg header was found.

    var $length = false;    // length of mp3 format hh:ss
    var $lengths = false;    // length of mp3 in seconds

    var $error = false;        // if any errors they will be here

    var $debug = false;        // print debugging info?
    var $debugbeg = '<DIV STYLE="margin: 0.5 em; padding: 0.5 em; border-width: thin; border-color: black; border-style: solid">';
    var $debugend = '</DIV>';

    /*
     * id3 constructor - creates a new id3 object and maybe loads a tag
     * from a file.
     *
     * $file - the path to the mp3/mpeg file. When in doubt use a full path.
     * $study - (Optional) - study the mpeg frame to get extra info like bitrate and frequency
     *        You should advoid studing alot of files as it will significantly slow this down.
     */
    function id3($file, $study = false) {
    if (defined('ID3_SHOW_DEBUG')) $this->debug = true;
    if ($this->debug) print($this->debugbeg . "id3('$file')<HR>\n");

    $this->file = $file;
    $this->_read_v1();
    $this->_read_v2();

    if ($study or defined('ID3_AUTO_STUDY'))
        $this->study();

    if ($this->debug) print($this->debugend);
    } // id3($file)

    /*
     * write($v1) - update the id3v1 tags on the file.
     *
     * $v1 - if true update/create an id3v1 tag on the file. (defaults to true)
     *
     * Note: If/when ID3v2 is implemented this method will probably get another
     *       parameters.
     */
    function write($v1 = true) {
    	if ($this->debug) print($this->debugbeg . "write()<HR>\n");
    	if ($v1) {
    	    $this->_write_v1();
    	}
    	if ($this->debug) print($this->debugend);
    } // write()

    /*
     * study() - does extra work to get the MPEG frame info.
     */
    function study() {
	    $this->studied = true;
	    $this->_readframe();
    } // study()

    /*
     * copy($from) - set's the ID3 fields to the same as the fields in $from
     */
    //function copy($from) {
   // if ($this->debug) print($this->debugbeg . "copy(\$from)<HR>\n");
    //$this->name    = $from->name;
    //$this->artists    = $from->artists;
    //$this->album    = $from->album;
    //$this->year    = $from->year;
    //$this->comment    = $from->comment;
    //$this->track    = $from->track;
    //$this->genre    = $from->genre;
    //$this->genreno    = $from->genreno;
    //if ($this->debug) print($this->debugend);
    //} // copy($from)

    /*
     * remove($id3v1, $id3v2) - removes the id3 tag(s) from a file.
     *
     * $id3v1 - (optional) true to remove the tag
     * $id3v2 - (optional) true to remove the tag (Not yet implemented)
     */
    //function remove($id3v1 = true, $id3v2 = true) {
    //if ($this->debug) print($this->debugbeg . "remove()<HR>\n");

    //if ($id3v1) {
    //    $this->_remove_v1();
    //}

    //if ($id3v2) {
    //    // TODO: write ID3v2 code
    //}

    //if ($this->debug) print($this->debugend);
    //} // remove


    /*
     * _read_v1() - read a ID3 v1 or v1.1 tag from a file
     *
     * if there is an error it will return false and a message will be
     * put in $this->error
     */
    function _read_v1() {
    if ($this->debug) print($this->debugbeg . "_read_v1()<HR>\n");

    if (! ($f = fopen($this->file, 'rb')) ) {
        $this->error = 'Unable to open ' . $file;
        return false;
    }

    if (fseek($f, -128, SEEK_END) == -1) {
        $this->error = 'Unable to see to end - 128 of ' . $file;
        return false;
    }

    $r = fread($f, 128);
    fclose($f);

    /*
    if ($this->debug) {
        $unp = unpack('H*raw', $r);
        print_r($unp);
    }
    */

    $id3tag = $this->_decode_v1($r);
	
    if($id3tag) {
        $this->id3v1 = true;

        $tmp = explode(Chr(0), $id3tag['NAME']);
        $this->name = $tmp[0];

        $tmp = explode(Chr(0), $id3tag['ARTISTS']);
        $this->artists = $tmp[0];

        $tmp = explode(Chr(0), $id3tag['ALBUM']);
        $this->album = $tmp[0];

        $tmp = explode(Chr(0), $id3tag['YEAR']);
        $this->year = $tmp[0];

        $tmp = explode(Chr(0), $id3tag['COMMENT']);
        $this->comment = $tmp[0];

        if (isset($id3tag['TRACK'])) {
        $this->id3v11 = true;
        $this->track = $id3tag['TRACK'];
        }

        $this->genreno = $id3tag['GENRENO'];
        $this->genre = $id3tag['GENRE'];
    } else {
        if ($this->debug) print("<B>ID3v1 Tag not found</B>\n");
    }

    if ($this->debug) print($this->debugend);
    } // _read_v1()

    /*
     * _read_v2 - read a ID3 v2 tag from a file
     *
     * if there is an error it will return false and a message will be
     * put in $this->error
     */
    function _read_v2() {
    if ($this->debug) print($this->debugbeg . "_read_v2()<HR>\n");

    if (! ($f = fopen($this->file, 'rb')) ) {
        $this->error = 'Unable to open ' . $file;
        return false;
    }

    $format = 'a3TAG/C1MAJOR/C1MINOR/H2FLAGS/H8SIZE'; // Tag header
    // XXX: For now we'll assume ID3v2 tags are only at the beggining of the file.
    $r = fread($f, 10);
    $header = unpack($format, $r);

    if (!($header['TAG'] == 'ID3' and ($header['MAJOR'] == 3 or $header['MAJOR'] 
== 4))) {
        // Only ID3v2 version 3 or 4 supported.
        $this->error = 'ID3v2.' . $header['MAJOR'] . ' not supported!';
        if ($this->debug)
        print($this->error . $this->debugend);
        return false;
    }

    $header['FLAGS'] = $this->_decode_v2_tag_flags($header['FLAGS']);
    $header['TAGSIZE'] = $this->_decode_synchsafe($header['SIZE']);
    if ($this->debug) print_r($header);

    // Yea I know the minor isn't a fraction but whatever.
    $this->id3v2 = $header['MAJOR'] . '.' . $header['MINOR'];

    if ($header['FLAGS']['extended']) {
        // TODO: read extened header info, this should skip it ... I think
        if ($this->debug)
        echo "<B>Attempting to skip tag extened header, cross your 
fingers</B>\n";
        $r = fread($f, 4);
        $extended = unpack('H8SIZE', $r);
        // I hope this is right.
        if ($header['MAJOR'] == 4) {
        $extended['TAGSIZE'] = $this->_decode_synchsafe($extended['SIZE']);
        } else {
        $extended['TAGSIZE'] = base_convert($extended['SIZE'], 16, 10);
        }
        fread($f, $extended['TAGSIZE'] - 4); // XXX: I think
    }


    // The 2.3 and 2.4 frames have the same frame header format but the bits aren't the same.
    $format = 'a4FRAMEID/H8SIZE/H4FLAGS'; // Frame header
    $frames = array();
    $byteread = 0;
    while ($header['TAGSIZE'] > $byteread) {
        if ($this->debug) {
        echo "<B>Tag Size: ", $header['TAGSIZE'];
        echo " ftell: ", ftell($f);
        echo " Bytes read: ", $byteread, "</B>\n";
        }

        $r = fread($f, 10);
        $byteread += 10;
        $fheader = unpack($format, $r);
        if ($header['MAJOR'] == 4) {
        // ID3v2.4 sizes are sync safed
        $fheader['FRAMESIZE'] = $this->_decode_synchsafe($fheader['SIZE']);
        } else if ($header['MAJOR'] == 3) {
        // ID3v2.3 sizes are not sync safed
        $fheader['FRAMESIZE'] = base_convert($fheader['SIZE'], 16, 10);
        }
        $fheader['FLAGS'] = $this->_decode_v2_frame_flags($fheader['FLAGS'], 
$header['MAJOR']);

        // TODO: Handle Frame flags

        if ($this->debug) print_r("<B>Frame Size: " .$fheader['FRAMESIZE']. 
"</B>\n");
        if ($fheader['FRAMESIZE'] > 0) {
        $frame = fread($f, $fheader['FRAMESIZE']);
        $byteread += $fheader['FRAMESIZE'];

        // Unsyncronize this crap. XXX: This could be perfect or buggy as hell.
        if ($header['FLAGS']['unsynchronisation'] or isset($fheader['unsynchronisation'])) {
            $unsyncs = substr_count($frame, Chr(255) . Chr(0));
            while ($unsyncs != 0) {
            if ($this->debug) echo "<B>UnSyncs: $unsyncs</B>\n";
            $unsyncdata = fread($f, $unsyncs);
            $byteread += $unsyncs;
            $unsyncs = substr_count($unsyncdata, Chr(255) . Chr(0));
            $frame .= $unsyncdata;
            }
        }

        $this->_v2_add_frame($frames, $fheader, $frame);

        if ($this->debug) {
            echo $fheader['FRAMEID'], "\n";
            print_r($frames[$fheader['FRAMEID']]);
        }
        } else {
        // Skip padding
        if ($this->debug) print_r("<B>FYI: Skipping Padding</B>\n");
        fread($f, $header['TAGSIZE'] - $byteread);
        $byteread += ($header['TAGSIZE'] - $byteread);
        }
    
    }

    if ($header['FLAGS']['footer']) {
        // XXX: Should I care?
        if ($this->debug) print_r("<B>FYI: Ignoring footer</B>\n");
    }
    //if ($this->debug) print_r($frames);

    $header['FRAMES'] = &$frames;

    $this->id3v2tag = &$header;

    if ($this->debug) print($this->debugend);
    } // _read_v2()

    function _v2_add_frame(&$frames, &$fheader, &$frame) {
    // TODO: This should be written so that $frames['TYPE'][#]['field']

    if ($fheader['FRAMEID'][0] == 'T' and $fheader['FRAMEID'] != 'TXXX') {
        $frames[$fheader['FRAMEID']] = array(
            'encoding' => $frame[0],
            'data' => substr($frame, 1),
                        );
    } else if ($fheader['FRAMEID'] == 'TXXX') {
        $parts = substr($frame, 1);
        $parts = explode(Chr(0), $parts, 2);
        if (isset($frames[$fheader['FRAMEID']])) {
        $frames[$fheader['FRAMEID']]['data'][$parts[0]] = $parts[1];
        } else {
        $frames[$fheader['FRAMEID']] = array(
            'encoding' => $frame[0],
            'data'=> array($parts[0] => $parts[1]),
                            );
        }
    } else if ($fheader['FRAMEID'] == 'COMM') {
        $language = substr($frame, 1, 3);
        $parts = substr($frame, 4);
        $parts = explode(Chr(0), $parts, 2);
        if (isset($frames[$fheader['FRAMEID']])) {
        $frames[$fheader['FRAMEID']]['data'][$parts[0]] = $parts[1];
        } else {
        $frames[$fheader['FRAMEID']] = array(
            'encoding' => $frame[0],
            'language' => $language,
            'data'=> array($parts[0] => $parts[1]),
                            );
        }
    } else if ($fheader['FRAMEID'] == 'COMM') {
        $parts = explode(Chr(0), $parts, 3);
        $mime = substr($parts[0], 1);
        $type = $parts[1][0];
        $description = substr($parts[1], 1);
        // TODO: Finish this
    } else {
        $frames[$fheader['FRAMEID']] = array(
            'flags' => $fheader['FLAGS'],
            'size' => $fheader['FRAMESIZE'],
            'data' => $frame,
                        );
    }
    } // _v2_add_frame(&$frames, &$fheader, &$frame)

    function _decode_v2_tag_flags($flags) {
    if ($this->debug) print($this->debugbeg . 
"_decode_v2_tag_flags($flags)<HR>\n");

    $bits = $this->_hextobits($flags, 1);

    $flags = array('raw' => $flags);

    $flags['a'] = $bits[0]; // Unsynchronisation
    $flags['b'] = $bits[1]; // Extended header
    $flags['c'] = $bits[2]; // Experimental indicator
    $flags['d'] = $bits[3]; // Footer present
    $flags['e'] = $bits[4]; // Not defined
    $flags['f'] = $bits[5]; // Not defined
    $flags['g'] = $bits[6]; // Not defined
    $flags['h'] = $bits[7]; // Not defined

    $flags['unsynchronisation']= &$flags['a'];
    $flags['extended'] = &$flags['b'];
    $flags['experimental'] = &$flags['c'];
    $flags['footer'] = &$flags['d'];

    if ($this->debug) print_r($flags);

    if ($this->debug) print($this->debugend);
    return $flags;
    } // _decode_v2_tag_flags($flags)

    function _decode_v2_frame_flags($flags, $version) {
    if ($this->debug) print($this->debugbeg . "_decode_v2_frame_flags($flags, 
$version)<HR>\n");

    $bits = $this->_hextobits($flags, 2);

    $flags = array('raw' => $flags);

    $flags['a'] = $bits[0];
    $flags['b'] = $bits[1];
    $flags['c'] = $bits[2]; 
    $flags['d'] = $bits[3]; 
    $flags['e'] = $bits[4]; 
    $flags['f'] = $bits[5]; 
    $flags['g'] = $bits[6]; 
    $flags['h'] = $bits[7]; 

    $flags['i'] = $bits[8]; 
    $flags['j'] = $bits[9];
    $flags['k'] = $bits[10];
    $flags['l'] = $bits[11]; 
    $flags['m'] = $bits[12]; 
    $flags['n'] = $bits[13]; 
    $flags['o'] = $bits[14]; 
    $flags['p'] = $bits[15]; 

    if ($version == 3) {
        $flags['tag_alter_preservation'] = &$flags['a'];
        $flags['file_alter_preservation'] = &$flags['b'];
        $flags['read_only'] = &$flags['c'];
        $flags['compression'] = &$flags['i'];
        $flags['encryption'] = &$flags['j'];
        $flags['grouping_identity'] = &$flags['k'];
    } else if ($version == 4) {
        $flags['tag_alter_preservation'] = &$flags['b'];
        $flags['file_alter_preservation'] = &$flags['c'];
        $flags['read_only'] = &$flags['d'];
        $flags['grouping_identity'] = &$flags['j'];
        $flags['compression'] = &$flags['m'];
        $flags['encryption'] = &$flags['n'];
        $flags['unsynchronisation'] = &$flags['o'];
        $flags['data_length_indicator'] = &$flags['p'];
    }

    if ($this->debug) print($this->debugend);
    return $flags;
    } // _decode_v2_frame_flags($flags)

    function _decode_v2_frame($frameid, $size, $flags, $data) {
    if ($this->debug) print($this->debugbeg . "_decode_v2_frame<HR>\n");

    if ($this->debug) print($this->debugend);
    } // _decode_v2_frame($flags)

    function _decode_synchsafe($hex) {
    if ($this->debug) print($this->debugbeg . "_decode_synchsafe($hex)<HR>\n");

    $int = base_convert($hex, 16, 10);
    $int1 = floor($int/256) * 128 + ($int%256);
    $int2 = floor($int1/32768) * 16384 + ($int1%32768);
    $int = floor($int2/4194304) * 2097152 + ($int2%4194304);

    if ($this->debug) print($int);
    if ($this->debug) print($this->debugend);
    return $int;
    }

    /*
     * _decode_v1($rawtag) - decodes that ID3v1 or ID3v1.1 tag
     *
     * false will be returned if there was an error decoding the tag
     * else an array will be returned
     */
    function _decode_v1($rawtag) {
    if ($this->debug) print($this->debugbeg . "_decode_v1(\$rawtag)<HR>\n");
    if ($rawtag[125] == Chr(0) and $rawtag[126] != Chr(0)) {
        // ID3 v1.1
        $format = 
'a3TAG/a30NAME/a30ARTISTS/a30ALBUM/a4YEAR/a28COMMENT/x1/C1TRACK/C1GENRENO';
    } else {
        // ID3 v1
        $format = 
'a3TAG/a30NAME/a30ARTISTS/a30ALBUM/a4YEAR/a30COMMENT/C1GENRENO';
    }
	
    $id3tag = unpack($format, $rawtag);

    if ($id3tag['TAG'] == 'TAG') {
        $id3tag['GENRE'] = $this->getgenre($id3tag['GENRENO']);
    } else {
        $this->error = 'ID3v1 TAG not found';
        $id3tag = false;
    }
    if ($this->debug) print($this->debugend);
    return $id3tag;
    } // _decode_v1()


    /*
     * _write_v1() - writes a ID3 v1 or v1.1 tag to a file
     *
     * if there is an error it will return false and a message will be
     * put in $this->error
     */
    function _write_v1() {
    	if ($this->debug) print($this->debugbeg . "_write_v1()<HR>\n");

    	$file = $this->file;

    	if (! ($f = fopen($file, 'r+b')) ) {
    	    $this->error = 'Unable to open ' . $file;
    	    return false;
    	}

    	if (fseek($f, -128, SEEK_END) == -1) {
    	    $this->error = 'Unable to see to end - 128 of ' . $file;
    	    return false;
    	}

    	$this->genreno = $this->getgenreno($this->genre, $this->genreno);

    	$newtag = $this->_encode_v1();

    	$r = fread($f, 128);

    	if ($this->_decode_v1($r)) {
    	    if (fseek($f, -128, SEEK_END) == -1) {
    	    $this->error = 'Unable to see to end - 128 of ' . $file;
    	    return false;
    	    }
    	    fwrite($f, $newtag);
    	} else {
    	    if (fseek($f, 0, SEEK_END) == -1) {
    	    $this->error = 'Unable to see to end of ' . $file;
    	    return false;
    	    }
    	    fwrite($f, $newtag);
    	}
    	fclose($f);


    	if ($this->debug) print($this->debugend);
    } // _write_v1()

    /*
     * _encode_v1() - encode the ID3 tag
     *
     * the newly built tag will be returned
     */
    function _encode_v1() {
    if ($this->debug) print($this->debugbeg . "_encode_v1()<HR>\n");

    if ($this->track) {
        // ID3 v1.1
        $id3pack = 'a3a30a30a30a4a28x1C1C1';
        $newtag = pack($id3pack,
            'TAG',
            $this->name,
            $this->artists,
            $this->album,
            $this->year,
            $this->comment,
            $this->track,
            $this->genreno
              );
    } else {
        // ID3 v1
        $id3pack = 'a3a30a30a30a4a30C1';
        $newtag = pack($id3pack,
            'TAG',
            $this->name,
            $this->artists,
            $this->album,
            $this->year,
            $this->comment,
            $this->genreno
              );
    }

    if ($this->debug) {
        print('id3pack: ' . $id3pack . "\n");
        $unp = unpack('H*new', $newtag);
        print_r($unp);
    }

    if ($this->debug) print($this->debugend);
    return $newtag;
    } // _encode_v1()

    /*
     * _remove_v1() - if exists it removes an ID3v1 or v1.1 tag
     *
     * returns true if the tag was removed or none was found
     * else false if there was an error
     */
    //function _remove_v1() {
    //if ($this->debug) print($this->debugbeg . "_remove_v1()<HR>\n");

    //$file = $this->file;

    //if (! ($f = fopen($file, 'r+b')) ) {
    //    $this->error = 'Unable to open ' . $file;
    //    return false;
    //}

    //if (fseek($f, -128, SEEK_END) == -1) {
    //    $this->error = 'Unable to see to end - 128 of ' . $file;
    //    return false;
    //}

    //$r = fread($f, 128);

    //$success = false;
    //if ($this->_decode_v1($r)) {
    //    $size = filesize($this->file) - 128;
    //    if ($this->debug) print('size: old: ' . filesize($this->file));
    //    $success = ftruncate($f, $size);    
    //    clearstatcache();
    //    if ($this->debug) print(' new: ' . filesize($this->file));
    //}
    //fclose($f);
    //if ($this->debug) print($this->debugend);
    //return $success;
    //} // _remove_v1()

    /*
     * _readframe() - read a mpeg frame and extract header info.
     *
     * Help: Anyone know what the mode extensions are? Feel free to tell me.
     */
    function _readframe() {
    if ($this->debug) print($this->debugbeg . "_readframe()<HR>\n");

    $file = $this->file;

    if (! ($f = fopen($file, 'rb')) ) {
        $this->error = 'Unable to open ' . $file;
        if ($this->debug) print($this->debugend);
        return false;
    }

    $this->filesize = filesize($file);

    do {
        while (fread($f,1) != Chr(255)) { // Find the first frame
        //if ($this->debug) echo "Find...\n";
        if (feof($f)) {
            $this->error = 'No mpeg frame found';
            if ($this->debug) print($this->debugend);
            return false;
        }
        }
        fseek($f, ftell($f) - 1); // back up one byte

        $frameoffset = ftell($f);

        $r = fread($f, 4);
        // Binary to Hex to a binary sting. ugly but best I can think of.
        $bits = unpack('H8bits', $r);
        // Note: _hextobits times out here, take too long.
        $bits =  base_convert($bits['bits'],16,2);
    } while (!$bits[8] and !$bits[9] and !$bits[10]); // 1st 8 bits true from the while
    if ($this->debug) print('Bits: ' . $bits . "\n");

    $this->frameoffset = $frameoffset;

    fclose($f);

    if ($bits[11] == 0) {
        $this->mpeg_ver = "2.5";
        $bitrates = array(
            '1' => array(0, 32, 48, 56, 64, 80, 96, 112, 128, 144, 160, 176, 192, 224, 256, 0),
            '2' => array(0,  8, 16, 24, 32, 40, 48,  56,  64,  80,  96, 112, 128, 144, 160, 0),
            '3' => array(0,  8, 16, 24, 32, 40, 48,  56,  64,  80,  96, 112, 128, 144, 160, 0),
                 );
    } else if ($bits[12] == 0) {
        $this->mpeg_ver = "2";
        $bitrates = array(
            '1' => array(0, 32, 48, 56, 64, 80, 96, 112, 128, 144, 160, 176, 192, 224, 256, 0),
            '2' => array(0,  8, 16, 24, 32, 40, 48,  56,  64,  80,  96, 112, 128, 144, 160, 0),
            '3' => array(0,  8, 16, 24, 32, 40, 48,  56,  64,  80,  96, 112, 128, 144, 160, 0),
                 );
    } else {
        $this->mpeg_ver = "1";
        $bitrates = array(
            '1' => array(0, 32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448, 0),
            '2' => array(0, 32, 48, 56,  64,  80,  96, 112, 128, 160, 192, 224, 256, 320, 384, 0),
            '3' => array(0, 32, 40, 48,  56,  64,  80,  96, 112, 128, 160, 192, 224, 256, 320, 0),
                 );
    }
    if ($this->debug) print('MPEG' . $this->mpeg_ver . "\n");

    $layer = array(
        array(0,3),
        array(2,1),
              );
    $this->layer = $layer[$bits[13]][$bits[14]];
    if ($this->debug) print('layer: ' . $this->layer . "\n");

    if ($bits[15] == 0) {
        // It's backwards, if the bit is not set then it is protected.
        if ($this->debug) print("protected (crc)\n");
        $this->crc = true;
    }

    $bitrate = 0;
    if ($bits[16] == 1) $bitrate += 8;
    if ($bits[17] == 1) $bitrate += 4;
    if ($bits[18] == 1) $bitrate += 2;
    if ($bits[19] == 1) $bitrate += 1;
    $this->bitrate = $bitrates[$this->layer][$bitrate];

    $frequency = array(
        '1' => array(
            '0' => array(44100, 48000),
            '1' => array(32000, 0),
                ),
        '2' => array(
            '0' => array(22050, 24000),
            '1' => array(16000, 0),
                ),
        '2.5' => array(
            '0' => array(11025, 12000),
            '1' => array(8000, 0),
                  ),
          );
    $this->frequency = $frequency[$this->mpeg_ver][$bits[20]][$bits[21]];

    $this->padding = $bits[22];
    $this->private = $bits[23];

    $mode = array(
        array('Stereo', 'Joint Stereo'),
        array('Dual Channel', 'Mono'),
             );
    $this->mode = $mode[$bits[24]][$bits[25]];

    // XXX: I dunno what the mode extension is. Bits 26,27

    $this->copyright = $bits[28];
    $this->original = $bits[29];

    $emphasis = array(
        array('none', '50/15ms'),
        array('', 'CCITT j.17'),
             );
    $this->emphasis = $emphasis[$bits[30]][$bits[31]];

    if ($this->bitrate == 0) {
        $s = -1;
    } else {
        $s = ((8*filesize($this->file))/1000) / $this->bitrate;        
    }
    $this->length = 
sprintf('%02d:%02d',floor($s/60),floor($s-(floor($s/60)*60)));
    $this->lengths = (int)$s;

    if ($this->debug) print($this->debugend);
    } // _readframe()

    function _hextobits($bits, $bytes) {
    if ($this->debug) print($this->debugbeg . "_hextobits($bits, 
$bytes)<HR>\n");

    $bits = base_convert($bits,16,2);
    $bits = str_pad($bits, $bytes * 8, '0', STR_PAD_LEFT);

    if ($this->debug) print($this->debugend);
    return $bits;
    } // _hextobits($bits, $bytes)

    /*
     * getgenre($genreno) - return the name of a genre number
     *
     * if no genre number is specified the genre number from
     * $this->genreno will be used.
     *
     * the genre is returned or false if an error or not found
     * no error message is ever returned
     */
    function getgenre($genreno) {
    if ($this->debug) print($this->debugbeg . "getgenre($genreno)<HR>\n");

    $genres = $this->genres();
    if (isset($genres[$genreno])) {
        $genre = $genres[$genreno];
        if ($this->debug) print($genre . "\n");
    } else {
        $genre = '';
    }

    if ($this->debug) print($this->debugend);
    return $genre;
    } // getgenre($genreno)

    /*
     * getgenreno($genre, $default) - return the number of the genre name
     *
     * the genre number is returned or 0xff (255) if a match is not found
     * you can specify the default genreno to use if one is not found
     * no error message is ever returned
     */
    function getgenreno($genre, $default = 0xff) {
    if ($this->debug) print($this->debugbeg . 
"getgenreno('$genre',$default)<HR>\n");

    $genres = $this->genres();
    $genreno = false;
    if ($genre) {
        foreach ($genres as $no => $name) {
        if (strtolower($genre) == strtolower($name)) {
            if ($this->debug) print("$no:'$name' == '$genre'");
            $genreno = $no;
        }
        }
    }
    if ($genreno === false) $genreno = $default;
    if ($this->debug) print($this->debugend);
    return $genreno;
    } // getgenreno($genre, $default = 0xff)

    /*
     * genres() - reuturns an array of the ID3v1 genres
     */
    function genres() {
    return array(
        0   => 'Blues',
        1   => 'Classic Rock',
        2   => 'Country',
        3   => 'Dance',
        4   => 'Disco',
        5   => 'Funk',
        6   => 'Grunge',
        7   => 'Hip-Hop',
        8   => 'Jazz',
        9   => 'Metal',
        10  => 'New Age',
        11  => 'Oldies',
        12  => 'Other',
        13  => 'Pop',
        14  => 'R&B',
        15  => 'Rap',
        16  => 'Reggae',
        17  => 'Rock',
        18  => 'Techno',
        19  => 'Industrial',
        20  => 'Alternative',
        21  => 'Ska',
        22  => 'Death Metal',
        23  => 'Pranks',
        24  => 'Soundtrack',
        25  => 'Euro-Techno',
        26  => 'Ambient',
        27  => 'Trip-Hop',
        28  => 'Vocal',
        29  => 'Jazz+Funk',
        30  => 'Fusion',
        31  => 'Trance',
        32  => 'Classical',
        33  => 'Instrumental',
        34  => 'Acid',
        35  => 'House',
        36  => 'Game',
        37  => 'Sound Clip',
        38  => 'Gospel',
        39  => 'Noise',
        40  => 'Alternative Rock',
        41  => 'Bass',
        42  => 'Soul',
        43  => 'Punk',
        44  => 'Space',
        45  => 'Meditative',
        46  => 'Instrumental Pop',
        47  => 'Instrumental Rock',
        48  => 'Ethnic',
        49  => 'Gothic',
        50  => 'Darkwave',
        51  => 'Techno-Industrial',
        52  => 'Electronic',
        53  => 'Pop-Folk',
        54  => 'Eurodance',
        55  => 'Dream',
        56  => 'Southern Rock',
        57  => 'Comedy',
        58  => 'Cult',
        59  => 'Gangsta',
        60  => 'Top 40',
        61  => 'Christian Rap',
        62  => 'Pop/Funk',
        63  => 'Jungle',
        64  => 'Native US',
        65  => 'Cabaret',
        66  => 'New Wave',
        67  => 'Psychadelic',
        68  => 'Rave',
        69  => 'Showtunes',
        70  => 'Trailer',
        71  => 'Lo-Fi',
        72  => 'Tribal',
        73  => 'Acid Punk',
        74  => 'Acid Jazz',
        75  => 'Polka',
        76  => 'Retro',
        77  => 'Musical',
        78  => 'Rock & Roll',
        79  => 'Hard Rock',
        80  => 'Folk',
        81  => 'Folk-Rock',
        82  => 'National Folk',
        83  => 'Swing',
        84  => 'Fast Fusion',
        85  => 'Bebob',
        86  => 'Latin',
        87  => 'Revival',
        88  => 'Celtic',
        89  => 'Bluegrass',
        90  => 'Avantgarde',
        91  => 'Gothic Rock',
        92  => 'Progressive Rock',
        93  => 'Psychedelic Rock',
        94  => 'Symphonic Rock',
        95  => 'Slow Rock',
        96  => 'Big Band',
        97  => 'Chorus',
        98  => 'Easy Listening',
        99  => 'Acoustic',
        100 => 'Humour',
        101 => 'Speech',
        102 => 'Chanson',
        103 => 'Opera',
        104 => 'Chamber Music',
        105 => 'Sonata',
        106 => 'Symphony',
        107 => 'Booty Bass',
        108 => 'Primus',
        109 => 'Porn Groove',
        110 => 'Satire',
        111 => 'Slow Jam',
        112 => 'Club',
        113 => 'Tango',
        114 => 'Samba',
        115 => 'Folklore',
        116 => 'Ballad',
        117 => 'Power Ballad',
        118 => 'Rhytmic Soul',
        119 => 'Freestyle',
        120 => 'Duet',
        121 => 'Punk Rock',
        122 => 'Drum Solo',
        123 => 'Acapella',
        124 => 'Euro-House',
        125 => 'Dance Hall',
        126 => 'Goa',
        127 => 'Drum & Bass',
        128 => 'Club-House',
        129 => 'Hardcore',
        130 => 'Terror',
        131 => 'Indie',
        132 => 'BritPop',
        133 => 'Negerpunk',
        134 => 'Polsk Punk',
        135 => 'Beat',
        136 => 'Christian Gangsta Rap',
        137 => 'Heavy Metal',
        138 => 'Black Metal',
        139 => 'Crossover',
        140 => 'Contemporary Christian',
        141 => 'Christian Rock',
        142 => 'Merengue',
        143 => 'Salsa',
        144 => 'Trash Metal',
        145 => 'Anime',
        146 => 'Jpop',
        147 => 'Synthpop',
        148 => 'Christian',
        255 => 'Unknown'
            );
    } // genres()
} // end of class id3