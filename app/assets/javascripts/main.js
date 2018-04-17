function open_window(type)
{
  switch(type)
  {
    case "collar_type":
      url = '/collar_types/?mode=dialog';
      break;
    case "sleeve_type":
      url = '/sleeve_types/?mode=dialog';
      break;
    case "cuff_type":
      url = '/cuff_types/?mode=dialog';
      break;
    case "swimsuit_type":
      url = '/swimsuit_types/?mode=dialog';
      break;
    case "tops_type":
      url = '/tops_types/?mode=dialog';
      break;
    case "skirt_type":
      url = '/skirt_types/?mode=dialog';
      break;
  }
  window.open(url , 'SELECT', "width=500,height=700,resizable=yes,scrollbars=yes");
}

function dialog_select(name_id, name_val, id_id, id_val)
{
  $("#" + name_id).val(name_val);
  $("#" + id_id).val(id_val);
}
