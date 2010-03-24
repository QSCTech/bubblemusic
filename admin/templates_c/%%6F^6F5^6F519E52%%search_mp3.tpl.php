<?php /* Smarty version 2.6.22, created on 2010-03-16 08:03:30
         compiled from search_mp3.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('modifier', 'escape', 'search_mp3.tpl', 14, false),)), $this); ?>
<script language="javascript" src="templates/js/search_mp3.js"></script>
<link rel="stylesheet" type="text/css" href="templates/css/search_mp3.css" />
<ul id="mp3_list">
    <?php $_from = $this->_tpl_vars['songs']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['key'] => $this->_tpl_vars['item']):
?>
    <!--歌曲信息完整-->
    <?php if ($this->_tpl_vars['item']['album'] && $this->_tpl_vars['item']['artists'] && $this->_tpl_vars['item']['name'] && $this->_tpl_vars['item']['genre_id']): ?>
    <li class="block">
        <h2>待添加歌曲<?php echo $this->_tpl_vars['key']+1; ?>
 - <?php echo $this->_tpl_vars['item']['name']; ?>
</h2>
        <form>
            文件路径：<label><?php echo $this->_tpl_vars['item']['path']; ?>
</label><br />
            歌词路径：<label><?php if ($this->_tpl_vars['item']['lrc_path']): ?><?php echo $this->_tpl_vars['item']['lrc_path']; ?>
<?php else: ?>找不到歌词文件<?php endif; ?></label><br />
            <input type="hidden" value="<?php echo $this->_tpl_vars['item']['path']; ?>
" name="path" />
            <input type="hidden" value="<?php echo $this->_tpl_vars['item']['lrc_path']; ?>
" name="lrc_path" />
            专辑名：<input type="text" value="<?php echo ((is_array($_tmp=$this->_tpl_vars['item']['album'])) ? $this->_run_mod_handler('escape', true, $_tmp) : smarty_modifier_escape($_tmp)); ?>
" size="40" name="album"/>&nbsp;&nbsp;&nbsp;
            歌手名：<input type="text" value="<?php echo ((is_array($_tmp=$this->_tpl_vars['item']['artists'])) ? $this->_run_mod_handler('escape', true, $_tmp) : smarty_modifier_escape($_tmp)); ?>
" name="artists"/><br />
            歌曲名：<input type="text" value="<?php echo ((is_array($_tmp=$this->_tpl_vars['item']['name'])) ? $this->_run_mod_handler('escape', true, $_tmp) : smarty_modifier_escape($_tmp)); ?>
" size="40" name="name"/><br />
            歌曲类别 ： <select name="genre">
                            <?php $_from = $this->_tpl_vars['genres']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['genre_id'] => $this->_tpl_vars['genre']):
?>
                                <option <?php if ($this->_tpl_vars['genre_id'] == $this->_tpl_vars['item']['genre_id']): ?>selected<?php endif; ?> value="<?php echo $this->_tpl_vars['genre_id']; ?>
"><?php echo $this->_tpl_vars['genre']; ?>
</option>
                            <?php endforeach; endif; unset($_from); ?>
                        </select>
			专题：<select name="subject_id">
					<option value = "0">不加入专题</option>
                    <?php $_from = $this->_tpl_vars['subjects']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['subject']):
?>
                        <option value="<?php echo $this->_tpl_vars['subject']['subject_id']; ?>
"><?php echo $this->_tpl_vars['subject']['subject_name']; ?>
</option>
                    <?php endforeach; endif; unset($_from); ?>
                 </select>
        </form>
        <img src="templates/images/music_add_button.png" class="do_add" />
    </li>
    <!--歌曲信息不完整-->
    <?php else: ?>
    <li style="border:2px solid #F00;" class="block">
        <h2 style="border-bottom-color:#F00">待添加歌曲<?php echo $this->_tpl_vars['key']+1; ?>
 - <?php echo $this->_tpl_vars['item']['name']; ?>
(歌曲信息不完整,你可以修改id3信息重新上传或直接在这里修改)</h2>
        <form>
            文件路径：<label><?php echo $this->_tpl_vars['item']['path']; ?>
</label><br />
            <input type="hidden" value="<?php echo $this->_tpl_vars['item']['path']; ?>
" name="path" />
            <input type="hidden" value="<?php echo $this->_tpl_vars['item']['lrc_path']; ?>
" name="lrc_path" />
            专辑名：<input type="text" value="<?php echo $this->_tpl_vars['item']['album']; ?>
" size="40" name="album"/>&nbsp;&nbsp;&nbsp;
            歌手名：<input type="text" value="<?php echo $this->_tpl_vars['item']['artists']; ?>
" name="artists"/><br />
            歌曲名：<input type="text" value="<?php echo $this->_tpl_vars['item']['name']; ?>
" size="40" name="name"/><br />
            歌曲类别 ： <select>
                            <?php $_from = $this->_tpl_vars['genres']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['genre_id'] => $this->_tpl_vars['genre']):
?>
                                <option <?php if ($this->_tpl_vars['genre_id'] == $this->_tpl_vars['item']['genre_id']): ?>selected<?php endif; ?> value="<?php echo $this->_tpl_vars['genre_id']; ?>
"><?php echo $this->_tpl_vars['genre']; ?>
</option>
                            <?php endforeach; endif; unset($_from); ?>
                        </select>
			专题：<select>
					<option value = "0">不加入专题</option>
                    <?php $_from = $this->_tpl_vars['subjects']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['subject']):
?>
                        <option value="<?php echo $this->_tpl_vars['subject']['subject_id']; ?>
"><?php echo $this->_tpl_vars['subject']['subject_name']; ?>
</option>
                    <?php endforeach; endif; unset($_from); ?>
                 </select>
        </form>
    </li>
    <?php endif; ?>
    <?php endforeach; endif; unset($_from); ?>
</ul>