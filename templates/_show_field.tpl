<span>
  {{ m.kazoo[{kz_doc_field type=type doc_id=doc_id field=field_name account_id=account_id}] }}
  <i id="edit_{{ field_name }}" class="fa fa-edit pointer" title="Edit field"></i>
</span>
{% wire id="edit_"++field_name
        type="click"
        action={update target=field_name
                       template="_edit_field.tpl"
                       type=type
                       doc_id=doc_id
                       field_name=field_name
                       account_id=account_id
                       placeholder=placeholder
               }
%}
