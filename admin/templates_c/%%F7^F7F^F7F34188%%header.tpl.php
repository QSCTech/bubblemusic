<?php /* Smarty version 2.6.22, created on 2010-02-19 11:18:08
         compiled from header.tpl */ ?>
<div id="banner">
    <h1><?php echo $this->_tpl_vars['title']; ?>
</h1>
    <form id="search" method="GET" action="./">
        <div class="input_left"></div>
        <input type="hidden" value="page_music" name="action" />
        <input type="text" class="text" name="key"/>
        <input type="submit" class="submit" style="display:none;"/>
        <div class="input_right"></div>
        <?php echo '
        <script language="javascript">
			$("#search .input_right").click(function(){
				 $("#search .submit").click();
			})
		</script>
        '; ?>

        
    </form>
</div>
<div id="banner_shadow">
</div>