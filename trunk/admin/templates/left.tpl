<div id="left">
	<ul>
    	<li {if $file == "home"}class ="hover"{/if}>
        	<a href="./?action=page_home">专辑管理</a>
        </li>
        <li {if $file == "music"}class="hover"{/if}>
        	<a href="./?action=page_music">音乐管理</a>
        </li>
        <li {if $file == "subject" || $file == "manage_subject"}class="hover"{/if}>
        	<a href="./?action=page_subject">专题管理</a>
        </li>
        <li {if $file == "search_mp3"}class="hover"{/if}>
        	<a href="./?action=page_search_mp3">搜索ftp</a>
        </li>
    </ul>
</div>