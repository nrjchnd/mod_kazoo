<table id="rs_payments_lists_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th class="td-center">{_ Date _}</th>
            <th class="td-center">{_ Description _}</th>
            <th class="td-center">{_ Sum _}</th>
        </tr>
    </thead>
    <tbody>
            {% for transaction in m.kazoo[{kz_list_transactions account_id=account_id payments_month_chosen=payments_month_chosen type="credit"}] %}
                <tr id={{ transaction["id"] }} {% if transaction["subscription_id"] %}style="cursor: pointer;"{% endif %}>
                    <td class="td-center">
                      {{ transaction["created"]|inno_timestamp_to_date }}
                      {{ transaction["created"]|inno_timestamp_to_date:"show_tz_name" }}
                    </td>
                    <td class="td-center">
                      {% if transaction["description"] %}
                        {{ transaction["description"] }}
                      {% else %}
                        {{ transaction["reason"] }}
                      {% endif %}
                    </td>
                    <td class="td-center">
                      {{ transaction["amount"]|format_price:[".",""]|currency_sign }}
                    </td>
                </tr>
            {% endfor %}
    </tbody>
</table>

{% javascript %}
//var initSearchParam = $.getURLParam("filter");
var oTable = $('#rs_payments_lists_table').dataTable({
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

