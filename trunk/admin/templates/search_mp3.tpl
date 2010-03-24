<script language="javascript" src="templates/js/search_mp3.js"></script>
<link rel="stylesheet" type="text/css" href="templates/css/search_mp3.css" />
<ul id="mp3_list">
    {foreach from=$songs item=item key=key}
    <!--歌曲信息完整-->
    {if $item.album && $item.artists && $item.name && $item.genre_id}
    <li class="block">
        <h2>待添加歌曲{$key+1} - {$item.name}</h2>
        <form>
            文件路径：<label>{$item.path}</label><br />
            歌词路径：<label>{if $item.lrc_path}{$item.lrc_path}{else}找不到歌词文件{/if}</label><br />
            <input type="hidden" value="{$item.path}" name="path" />
            <input type="hidden" value="{$item.lrc_path}" name="lrc_path" />
            专辑名：<input type="text" value="{$item.album|escape}" size="40" name="album"/>&nbsp;&nbsp;&nbsp;
            歌手名：<input type="text" value="{$item.artists|escape}" name="artists"/><br />
            歌曲名：<input type="text" value="{$item.name|escape}" size="40" name="name"/><br />
            歌曲类别 ： <select name="genre">
                            {foreach from=$genres item=genre key=genre_id}
                                <option {if $genre_id == $item.genre_id}selected{/if} value="{$genre_id}">{$genre}</option>
                            {/foreach}
                        </select>
			专题：<select name="subject_id">
					<option value = "0">不加入专题</option>
                    {foreach from=$subjects item=subject}
                        <option value="{$subject.subject_id}">{$subject.subject_name}</option>
                    {/foreach}
                 </select>
        </form>
        <img src="templates/images/music_add_button.png" class="do_add" />
    </li>
    <!--歌曲信息不完整-->
    {else}
    <li style="border:2px solid #F00;" class="block">
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
			专题：<select>
					<option value = "0">不加入专题</option>
                    {foreach from=$subjects item=subject}
                        <option value="{$subject.subject_id}">{$subject.subject_name}</option>
                    {/foreach}
                 </select>
        </form>
    </li>
    {/if}
    {/foreach}
</ul>