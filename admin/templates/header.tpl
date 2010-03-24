<div id="banner">
    <h1>{$title}</h1>
    <form id="search" method="GET" action="./">
        <div class="input_left"></div>
        <input type="hidden" value="page_music" name="action" />
        <input type="text" class="text" name="key"/>
        <input type="submit" class="submit" style="display:none;"/>
        <div class="input_right"></div>
        {literal}
        <script language="javascript">
			$("#search .input_right").click(function(){
				 $("#search .submit").click();
			})
		</script>
        {/literal}
        
    </form>
</div>
<div id="banner_shadow">
</div>