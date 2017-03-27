
<table id="rs_periodic_services_table" class="table display table-striped table-condensed">
  <thead>
        <tr>
            <th>{_ Service ID _}</th>
            <th class="td-center">{_ Start date _}</th>
            <th class="td-center">{_ End date _}</th>
            <th class="td-center"></th>
            <th class="td-center"></th>
        </tr>
  </thead>
  <tbody>
    {% for fee in m.onbill[{periodic_fees account_id=account_id fees_type=m.session.show_periodic_fees}] %}
    <tr>
      <td>{{ fee["service_id"] }}</td>
      <td class="td-center">
        {{ fee["service_starts"]|inno_timestamp_to_date }} {{ fee["service_starts"]|inno_timestamp_to_date:"show_tz_name" }}
      </td>
      <td class="td-center">
        {% if fee["service_ends"] %}
          {{ fee["service_ends"]|inno_timestamp_to_date }} {{ fee["service_ends"]|inno_timestamp_to_date:"show_tz_name" }}
        {% else %}
          Neverending Dream...
        {% endif %}
      </td>
      <td class="td-center">
        {% if fee["service_ends"]|inno_timestamp_expired == "expired" %}
          <i id="info_{{ fee["id"] }}" class="fa fa-info-circle zprimary pointer" title="Details"></i>
        {% else %}
          <i id="info_{{ fee["id"] }}" class="fa fa-edit zprimary pointer" title="Details"></i>
        {% endif %}
        {% wire id="info_"++fee["id"]
                action={dialog_open title=_"Manage periodic service" ++ " " ++ fee["service_id"]
                                    template="_periodic_service.tpl"
                                    account_id=account_id
                                    fee_id=fee["id"]
                                    class="iamclass"
                       }
        %}
      </td>
           <td class="text-center">
               <i id="delete_{{ fee["id"] }}" class="fa fa-trash-o pointer"></i>
               {% wire id="delete_"++fee["id"]
                       action={confirm text=_"Do you really want to delete this service?"++" <br />"
                                       action={postback postback={mark_periodic_service_deleted fee_id=fee["id"] account_id=account_id}
                                                        delegate="mod_onbill"
                                              }
                              }
               %}
           </td>

    </tr>
    {% endfor %}
  </tbody>
</table>

{% javascript %}
//var initSearchParam = $.getURLParam("filter");
var oTable = $('#rs_periodic_services_table').dataTable({
"pagingType": "simple",
"bFilter" : true,
"aaSorting": [[ 0, "desc" ]],
"aLengthMenu" : [[5, 15, -1], [5, 15, "All"]],
"iDisplayLength" : 5,
"oLanguage" : {
        "sInfoThousands" : " ",
        "sLengthMenu" : "_MENU_ {_ lines per page _}",
        "sSearch" : "{_ Filter _}:",
        "sZeroRecords" : "{_ Nothing found, sorry _}",
        "sInfo" : "{_ Showing _} _START_ {_ to _} _END_ {_ of _} _TOTAL_ {_ entries _}",
        "sInfoEmpty" : "{_ Showing 0 entries _}",
        "sInfoFiltered" : "({_ Filtered from _} _MAX_ {_ entries _})",
        "oPaginate" : {
                "sPrevious" : "{_ Back _}",
                "sNext" : "{_ Forward _}"
        }
},

});

{% endjavascript %}

