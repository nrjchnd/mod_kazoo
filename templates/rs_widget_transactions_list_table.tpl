<table class="table table-condensed table-centered">
  <thead>
    <tr>
      <th colspan="3">
        {_ Opening balance _}
        <span style="float:right; padding-right:2em;">
          {{ m.kazoo[{kz_list_transactions account_id=account_id
                                           payments_month_chosen=payments_month_chosen
                                           type="monthly_rollup"
                    }][1]["amount"]|currency_sign
          }}
        </span>
      </th>
    </tr>
    <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="3"></td></tr>
  </thead>
</table>

{% include  "rs_widget_payments_list_lazy.tpl" transactions=transactions %}

<table class="table table-condensed table-centered">
  <thead>
    <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="3"></td></tr>
  </thead>
</table>

{% include  "rs_widget_monthly_fees_list_lazy.tpl" transactions=transactions %}

<table class="table table-condensed table-centered">
  <thead>
    <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="3"></td></tr>
  </thead>
</table>

{% include  "rs_widget_per_minute_calls_list_lazy.tpl" transactions=transactions %}

<table class="table table-condensed table-centered">
  <thead>
    <tr style="height: 10px; color: white!important; background-color: white!important;"><td colspan="3"></td></tr>
    <tr>
      <th colspan="3">
        {% if payments_month_chosen == now|date: 'm/Y' or not payments_month_chosen %} 
          {_ Current balance _}
          <span style="float:right; padding-right:2em;">
            {% include "_current_account_credit.tpl" %}
          </span>
        {% else %}
          {_ Closing balance _}
          <span style="float:right; padding-right:2em;">
            {{ m.kazoo[{kz_list_transactions account_id=account_id
                                             payments_month_chosen=payments_month_chosen
                                             type="next_month_rollup"
                      }]|currency_sign
            }}
          </span>
        {% endif %}
      </th>
    </tr>
  </thead>
</table>
