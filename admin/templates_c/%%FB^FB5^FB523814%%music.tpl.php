<?php /* Smarty version 2.6.22, created on 2010-02-20 13:43:18
         compiled from music.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('modifier', 'truncate', 'music.tpl', 58, false),array('modifier', 'replace', 'music.tpl', 60, false),)), $this); ?>
<script language="javascript" src="templates/js/music.js"></script>
<link rel="stylesheet" type="text/css" href="templates/css/music.css" />
<form action="./?action=do_del_music" method="post">
    <table id="music_list" cellpadding="0" cellspacing="0">
        <thead>
            <tr>
                <?php if ($this->_tpl_vars['page'] == 1): ?>
                <th width="27px">
                	<img src="templates/images/cursor_prev_unable.png" style="margin-top:1px"/>
                </th>
                <?php else: ?>
                <th width="27px">
                	<a href="./?action=page_music&page=<?php echo $this->_tpl_vars['page_prev']; ?>
&ob=<?php echo $this->_tpl_vars['ob']; ?>
&key=<?php echo $this->_tpl_vars['keyword']; ?>
">
                    	<img src="templates/images/cursor_prev.png" style="margin-top:1px"/>
                    </a>
               	</th>
                <?php endif; ?>
                <th class="delete">
                	删除
                </th>
                <th>
                	<a href="./?action=page_music&page=<?php echo $this->_tpl_vars['page']; ?>
&ob=music_name&aid=<?php echo $this->_tpl_vars['aid']; ?>
&key=<?php echo $this->_tpl_vars['keyword']; ?>
">
                    	名称
                    </a>
               </th>
                <th>
                	<a href="./?action=page_music&page=<?php echo $this->_tpl_vars['page']; ?>
&ob=artists_name&aid=<?php echo $this->_tpl_vars['aid']; ?>
&key=<?php echo $this->_tpl_vars['keyword']; ?>
">
                    	表演者
                    </a>
                </th>
                <th>
                	<a href="./?action=page_music&page=<?php echo $this->_tpl_vars['page']; ?>
&ob=album_name&aid=<?php echo $this->_tpl_vars['aid']; ?>
&key=<?php echo $this->_tpl_vars['keyword']; ?>
">
                    	专辑
                    </a>
                </th>
                <th>
                	<a href="./?action=page_music&page=<?php echo $this->_tpl_vars['page']; ?>
&ob=genre&aid=<?php echo $this->_tpl_vars['aid']; ?>
&key=<?php echo $this->_tpl_vars['keyword']; ?>
">
                    	风格
                    </a>
               	</th>
                <?php if ($this->_tpl_vars['page'] == $this->_tpl_vars['page_all']): ?>
                <th width="30px">
                	<img src="templates/images/cursor_next_unable.png" style="margin-top:1px"/>
                </th>
                <?php else: ?>
                <th width="30px">
                	<a href="./?action=page_music&page=<?php echo $this->_tpl_vars['page_next']; ?>
&ob=<?php echo $this->_tpl_vars['ob']; ?>
&key=<?php echo $this->_tpl_vars['keyword']; ?>
">
                    	<img src="templates/images/cursor_next.png"  style="margin-top:1px"/>
                   	</a>
                </th>
                <?php endif; ?>
            </tr>
        </thead>
        <tbody>
        <?php if ($this->_tpl_vars['music']): ?>
            <?php $_from = $this->_tpl_vars['music']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['key'] => $this->_tpl_vars['item']):
?>
                <tr class="tr_style_<?php echo $this->_tpl_vars['key']%2; ?>
" id="<?php echo $this->_tpl_vars['item']['music_id']; ?>
_music">
                    <td><input type="hidden" value="<?php echo $this->_tpl_vars['source']; ?>
<?php echo ((is_array($_tmp=$this->_tpl_vars['item']['upload_date'])) ? $this->_run_mod_handler('truncate', true, $_tmp, 7, "") : smarty_modifier_truncate($_tmp, 7, "")); ?>
/<?php echo $this->_tpl_vars['item']['artists_name']; ?>
 - <?php echo $this->_tpl_vars['item']['album_name']; ?>
/<?php echo $this->_tpl_vars['item']['music_name']; ?>
" name="path_<?php echo $this->_tpl_vars['item']['music_id']; ?>
"/></td>
                    <td><input type="checkbox" name="music[]" value="<?php echo $this->_tpl_vars['item']['music_id']; ?>
"/></td>
                    <td class="music_name"><?php echo ((is_array($_tmp=$this->_tpl_vars['item']['music_name'])) ? $this->_run_mod_handler('replace', true, $_tmp, $this->_tpl_vars['keyword'], "<span class='highlight'>".($this->_tpl_vars['keyword'])."</span>") : smarty_modifier_replace($_tmp, $this->_tpl_vars['keyword'], "<span class='highlight'>".($this->_tpl_vars['keyword'])."</span>")); ?>
</td>
                    <td><?php echo $this->_tpl_vars['item']['artists_name']; ?>
</td>
                    <td><?php echo $this->_tpl_vars['item']['album_name']; ?>
</td>
                    <td><?php echo $this->_tpl_vars['genres'][$this->_tpl_vars['item']['genre']]; ?>
</td>
                    <td><a href="../bubble/#<?php echo $this->_tpl_vars['item']['music_id']; ?>
">试听</a></td>
                </tr>
            <?php endforeach; endif; unset($_from); ?>
        <?php else: ?>
            <tr>
                <td colspan="7" align="center">没有符合要求的歌曲</td>
            </tr>
        <?php endif; ?>
        </tbody>
        <thead>
            <tr>
                <?php if ($this->_tpl_vars['page'] == 1): ?>
                <th width="27px">
                	<img src="templates/images/cursor_prev_unable.png" style="margin-top:1px"/>
                </th>
                <?php else: ?>
                <th width="27px">
                	<a href="./?action=page_music&page=<?php echo $this->_tpl_vars['page_prev']; ?>
&ob=<?php echo $this->_tpl_vars['ob']; ?>
&key=<?php echo $this->_tpl_vars['keyword']; ?>
">
                    	<img src="templates/images/cursor_prev.png" style="margin-top:1px"/>
                    </a>
               	</th>
                <?php endif; ?>
                <th class="choose_all"><input type="checkbox"/></th>
                <th>
                	<a href="./?action=page_music&page=<?php echo $this->_tpl_vars['page']; ?>
&ob=music_name&aid=<?php echo $this->_tpl_vars['aid']; ?>
&key=<?php echo $this->_tpl_vars['keyword']; ?>
">
                    	名称
                    </a>
               </th>
                <th>
                	<a href="./?action=page_music&page=<?php echo $this->_tpl_vars['page']; ?>
&ob=artists_name&aid=<?php echo $this->_tpl_vars['aid']; ?>
&key=<?php echo $this->_tpl_vars['keyword']; ?>
">
                    	表演者
                    </a>
                </th>
                <th>
                	<a href="./?action=page_music&page=<?php echo $this->_tpl_vars['page']; ?>
&ob=album_name&aid=<?php echo $this->_tpl_vars['aid']; ?>
&key=<?php echo $this->_tpl_vars['keyword']; ?>
">
                    	专辑
                    </a>
                </th>
                <th>
                	<a href="./?action=page_music&page=<?php echo $this->_tpl_vars['page']; ?>
&ob=genre&aid=<?php echo $this->_tpl_vars['aid']; ?>
&key=<?php echo $this->_tpl_vars['keyword']; ?>
">
                    	风格
                    </a>
               	</th>
                <?php if ($this->_tpl_vars['page'] == $this->_tpl_vars['page_all']): ?>
                <th width="27px">
                	<img src="templates/images/cursor_next_unable.png" style="margin-top:1px"/>
                </th>
                <?php else: ?>
                <th width="27px">
                	<a href="./?action=page_music&page=<?php echo $this->_tpl_vars['page_next']; ?>
&ob=<?php echo $this->_tpl_vars['ob']; ?>
&key=<?php echo $this->_tpl_vars['keyword']; ?>
">
                    	<img src="templates/images/cursor_next.png"  style="margin-top:1px"/>
                   	</a>
                </th>
                <?php endif; ?>
            </tr>
        </thead>
    </table>
    <input type="hidden" value="<?php echo $this->_tpl_vars['page']; ?>
" name="page" />
    <input type="hidden" value="<?php echo $this->_tpl_vars['list_type']; ?>
" name="list_type" />
    <input type="hidden" value="<?php echo $this->_tpl_vars['order_by']; ?>
" name="order_by" />
    <input type="submit" style="display:none" />
</form>