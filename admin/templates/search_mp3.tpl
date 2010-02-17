<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="templates/css/common.css" />
<link rel="stylesheet" type="text/css" href="templates/css/search_mp3.css" />
<script language="javascript" src="templates/lib/jquery/jquery-1.3.2.js"></script>
<script language="javascript" src="templates/js/search_mp3.js"></script>
<title>bubble管理 - 搜索音乐</title>
</head>
<body>
    {include file=header.tpl title = "bubble管理 - 搜索音乐"}
    
    <div id="container">
    {include file = left.tpl}
    <div id="right">
        <ul id="mp3_list">
            {foreach from=$songs item=item key=key}
            {if $item.album && $item.artists && $item.name && $item.genre_id}
            <li class="block">
                <h2>待添加歌曲{$key+1} - {$item.name}</h2>
                <form>
                    文件路径：<label>{$item.path}</label><br />
                    歌词路径：<label>{if $item.lrc_path}{$item.lrc_path}{else}找不到歌词文件{/if}</label><br />
                    <input type="hidden" value="{$item.path}" name="path" />
                    <input type="hidden" value="{$item.lrc_path}" name="lrc_path" />
                    专辑名：<input type="text" value="{$item.album}" size="40" name="album"/>&nbsp;&nbsp;&nbsp;
                    歌手名：<input type="text" value="{$item.artists}" name="artists"/><br />
                    歌曲名：<input type="text" value="{$item.name}" size="40" name="name"/><br />
                    歌曲类别 ： <select>
                                    {foreach from=$genres item=genre key=genre_id}
                                        <option {if $genre_id == $item.genre_id}selected{/if} value="{$genre_id}">{$genre}</option>
                                    {/foreach}
                                </select>
                </form>
                <img src="templates/images/music_add_button.png" class="button" />
            </li>
            {else}
            <li style="border-color:#F00;" class="block">
                <h2 style="border-bottom-color:#F00">待添加歌曲{$key+1} - {$item.name}(歌曲信息不完整,你可以修改id3信息重新上传或直接在这里修改)</h2>
                <form>
                    文件路径：<label>{$item.path}</label><br />
                    <input type="hidden" value="{$item.path}" name="path" />
                    <input type="hidden" value="{$item.lrc_path}" name="lrc_path" />
                    专辑名：<input type="text" value="{$item.album}" size="40" name="album"/>&nbsp;&nbsp;&nbsp;
                    歌手名：<input type="text" value="{$item.artists}" name="artists"/><br />
                    歌曲名：<input type="text" value="{$item.name}" size="40" name="name"/><br />
                    歌曲类别 ： <select>
                                    {foreach from=$genres item=genre key=genre_id}
                                        <option {if $genre_id == $item.genre_id}selected{/if} value="{$genre_id}">{$genre}</option>
                                    {/foreach}
                                </select>
                </form>
            </li>
            {/if}
            {/foreach}
        </ul>
    </div>
</body>
</html>