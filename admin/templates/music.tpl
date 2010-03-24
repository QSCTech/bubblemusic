<script language="javascript" src="templates/js/music.js"></script>
<link rel="stylesheet" type="text/css" href="templates/css/music.css" />
<form action="./?action=do_del_music" method="post">
    <table id="music_list" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                {if $page == 1}
                <th width="27px">
                	<img src="templates/images/cursor_prev_unable.png" style="margin-top:1px"/>
                </th>
                {else}
                <th width="27px">
                	<a href="./?action=page_music&page={$page_prev}&ob={$ob}&key={$keyword}">
                    	<img src="templates/images/cursor_prev.png" style="margin-top:1px"/>
                    </a>
               	</th>
                {/if}
                <th class="delete">
                	删除
                </th>
                <th>
                	<a href="./?action=page_music&page={$page}&ob=music_name&aid={$aid}&key={$keyword}">
                    	名称
                    </a>
               </th>
                <th>
                	<a href="./?action=page_music&page={$page}&ob=artists_name&aid={$aid}&key={$keyword}">
                    	表演者
                    </a>
                </th>
                <th>
                	<a href="./?action=page_music&page={$page}&ob=album_name&aid={$aid}&key={$keyword}">
                    	专辑
                    </a>
                </th>
                <th>
                	<a href="./?action=page_music&page={$page}&ob=genre&aid={$aid}&key={$keyword}">
                    	风格
                    </a>
               	</th>
                {if $page == $page_all}
                <th width="30px">
                	<img src="templates/images/cursor_next_unable.png" style="margin-top:1px"/>
                </th>
                {else}
                <th width="30px">
                	<a href="./?action=page_music&page={$page_next}&ob={$ob}&key={$keyword}">
                    	<img src="templates/images/cursor_next.png"  style="margin-top:1px"/>
                   	</a>
                </th>
                {/if}
            </tr>
        </thead>
        <tbody>
        {if $music}
            {foreach from=$music item=item key=key}
                <tr class="tr_style_{$key%2}" id="{$item.music_id}_music">
                    <td><input type="hidden" value="{$source}{$item.upload_date|truncate:7:""}/{$item.artists_name} - {$item.album_name}/{$item.music_name}" name="path_{$item.music_id}"/></td>
                    <td><input type="checkbox" name="music[]" value="{$item.music_id}"/></td>
                    <td class="music_name">{$item.music_name|replace:$keyword:"<span class='highlight'>$keyword</span>"}</td>
                    <td>{$item.artists_name}</td>
                    <td>{$item.album_name}</td>
                    <td>{$genres[$item.genre]}</td>
                    <td><a href="../bubble/#{$item.music_id}">试听</a></td>
                </tr>
            {/foreach}
        {else}
            <tr>
                <td colspan="7" align="center">没有符合要求的歌曲</td>
            </tr>
        {/if}
        </tbody>
        <thead>
            <tr>
                {if $page == 1}
                <th width="27px">
                	<img src="templates/images/cursor_prev_unable.png" style="margin-top:1px"/>
                </th>
                {else}
                <th width="27px">
                	<a href="./?action=page_music&page={$page_prev}&ob={$ob}&key={$keyword}">
                    	<img src="templates/images/cursor_prev.png" style="margin-top:1px"/>
                    </a>
               	</th>
                {/if}
                <th class="choose_all"><input type="checkbox"/></th>
                <th>
                	<a href="./?action=page_music&page={$page}&ob=music_name&aid={$aid}&key={$keyword}">
                    	名称
                    </a>
               </th>
                <th>
                	<a href="./?action=page_music&page={$page}&ob=artists_name&aid={$aid}&key={$keyword}">
                    	表演者
                    </a>
                </th>
                <th>
                	<a href="./?action=page_music&page={$page}&ob=album_name&aid={$aid}&key={$keyword}">
                    	专辑
                    </a>
                </th>
                <th>
                	<a href="./?action=page_music&page={$page}&ob=genre&aid={$aid}&key={$keyword}">
                    	风格
                    </a>
               	</th>
                {if $page == $page_all}
                <th width="27px">
                	<img src="templates/images/cursor_next_unable.png" style="margin-top:1px"/>
                </th>
                {else}
                <th width="27px">
                	<a href="./?action=page_music&page={$page_next}&ob={$ob}&key={$keyword}">
                    	<img src="templates/images/cursor_next.png"  style="margin-top:1px"/>
                   	</a>
                </th>
                {/if}
            </tr>
        </thead>
    </table>
    <input type="hidden" value="{$page}" name="page" />
    <input type="hidden" value="{$list_type}" name="list_type" />
    <input type="hidden" value="{$order_by}" name="order_by" />
    <input type="submit" style="display:none" />
</form>