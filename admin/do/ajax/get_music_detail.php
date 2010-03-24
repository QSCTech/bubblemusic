<?php
	$music_id = $_POST["music_id"];
	
	$path = get_path4music_id($music_id);
	$path["mp3"] = is_file($path["mp3"]) ? $path["mp3"] : "";
	$path["lrc"] = is_file($path["lrc"]) ? $path["lrc"] : "歌词文件不存在";
	$id3 = new id3($path["mp3"]);
	$path["mp3"] = $path["mp3"] ? $path["mp3"] : "歌曲文件不存在";
	//基本信息
	$name = is_utf8($id3->name) ? $id3->name : mb_convert_encoding($id3->name,"UTF-8","GBK");
	$album = is_utf8($id3->album) ? $id3->album : mb_convert_encoding($id3->album,"UTF-8","GBK");
	$artists = is_utf8($id3->artists) ? $id3->artists : mb_convert_encoding($id3->artists,"UTF-8","GBK");
	$year = $id3->year;
	$track = $id3->track;
	$genre = $id3->genre;
	$genreno = $id3->genreno;
	//frame stuff
	$mpeg_ver = $id3->mpeg_ver;
	$layer = $id3->layer;
	$bitrate = $id3->bitrate;
	$frequency = $id3->frequency;
	$length = $id3->length;
	$filesize = $id3->filesize;
	
	$html = "<h2>$name</h2>
			<table class='detail'>
				<input type='hidden' name='music_id' value='$music_id' />
				<tr>
					<td colspan='2'><h3>歌曲信息</h3></td>
				</tr>
				<tr>
					<td><b>歌曲名</b></td>
					<td><input name=\"music_name\" value=\"$name\"/></td>
				</tr>
				<tr>
					<td><b>专辑</b></td>
					<td><input name=\"album_name\" value=\"$album\" /></td>
				</tr>
				<tr>
					<td><b>表演家</b></td>
					<td><input name=\"artists_name\" value=\"$artists\" /></td>
				</tr>
				<tr>
					<td><b>发行年份</b></td>
					<td>$year</td>
				</tr>
				<tr>
					<td><b>音轨</b></td>
					<td>$track</td>
				</tr>
				<tr>
					<td><b>流派</b></td>
					<td>
						<select name='genre'>";
				foreach($genre_list as $key=>$item){
					if($genreno != $key)
						$html.="<option value='$key'>$item</option>";
					else
						$html.="<option value='$key' selected>$item</option>";
				}
				$html.=	"</select>
					</td>
				</tr>
			</table>
			<div class='divid'></div>
			<table class='digital'>
				<tr>
					<td colspan='2'><h3>摘要</h3></td>
				</tr>
				<tr>
					<td><b>格式</b></td>
					<td>MPEG-{$mpeg_ver}，Layer $layer</td>
				</tr>
				<tr>
					<td><b>比特率</b></td>
					<td>$bitrate Kbps</td>
				</tr>
				<tr>
				</tr>
				<tr>
					<td><b>采样速率</b></td>
					<td>$frequency hz</td>
				</tr>
				<tr>
					<td><b>歌曲长度</b></td>
					<td>$length</td>
				</tr>
				<tr>
					<td><b>文件大小</b></td>
					<td>$filesize Byte</td>
				</tr>
			</table>
			<div class='path'><b>歌曲路径：</b>{$path['mp3']}</div>
			<div class='path'><b>歌词路径：</b><span class='lrc_path'>{$path['lrc']}</span></div>
			<h3>上传歌词:</h3>
			<input type='file' name='upload' id='upload' />
			<br />
			<button class='update'>更新信息</button>
			";
	echo $html;
?>