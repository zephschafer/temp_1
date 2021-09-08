view: negotiations {
  derived_table: {
    distribution_style: all
    sql: SELECT rep.name||'_'||neg.action||'_'||neg.created_at AS PK
           , neg.negotiation_id
           , JSON_EXTRACT_PATH_TEXT(neg.data,'party') AS user_type
           , rep.Name AS User
           --, neg.action AS Offer_Start_Type_ID
           , al.label AS offer_start_type
           , LEAD(al.label,1) OVER (ORDER BY neg.created_at DESC) AS offer_end_type
           , JSON_EXTRACT_PATH_TEXT(neg.data,'amount_cents')::FLOAT/100 AS amount
           , neg.created_at AS offer_start_time
           , LEAD(neg.created_at,1) OVER (PARTITION BY representative_id ORDER BY neg.created_at DESC) AS offer_end_time
           , nmm.max_offer_amount
           , nmm.min_offer_amount
           , ROW_NUMBER() OVER (PARTITION BY neg.negotiation_id
                                    ORDER BY neg.created_at ASC) AS negotiation_offer_num
           , ROW_NUMBER() OVER (PARTITION BY neg.representative_id, neg.negotiation_id
                                    ORDER BY neg.created_at ASC) AS user_negotiation_offer_num
        FROM public.negotiation_events neg
        LEFT JOIN public.representatives rep ON rep.id = neg.representative_id
        LEFT JOIN ${action_labels.SQL_TABLE_NAME} AS al ON neg.action = al.id
        LEFT JOIN (SELECT negotiation_id
                        , MAX(JSON_EXTRACT_PATH_TEXT(data,'amount_cents')::FLOAT/100) AS max_offer_amount
                        , MIN(JSON_EXTRACT_PATH_TEXT(data,'amount_cents')::FLOAT/100) AS min_offer_amount
                     FROM public.negotiation_events
                     WHERE action = 1
                       AND JSON_EXTRACT_PATH_TEXT(data,'party') = 'buyer'
                     GROUP BY negotiation_id) nmm ON nmm.negotiation_id = neg.negotiation_id
        WHERE JSON_EXTRACT_PATH_TEXT(neg.data,'reversion') = 'false';;

      sql_trigger_value:  SELECT MAX(CREATED_AT) FROM public.negotation_events;;
    }

###dimensions

    dimension: PK {
      primary_key: yes
      hidden: yes
      type: string
      sql: ${TABLE}.pk ;;
    }

    dimension: negotiation_id {
      type: number
      sql: ${TABLE}.negotiation_id ;;
    }

    dimension: user_type {
      type: string
      sql: ${TABLE}.user_type ;;
    }

    dimension: offer_start_type {
      type: string
      sql: ${TABLE}.offer_start_type ;;
    }

    dimension: offer_end_type {
      type: string
      sql: ${TABLE}.offer_end_type ;;
    }

    dimension: amount {
      type: number
      sql: ${TABLE}.amount ;;
      value_format_name: usd
    }

    dimension_group: offer_start {
      type: time
      timeframes: [raw,date,month,time,time_of_day,hour_of_day,quarter,year]
      sql: ${TABLE}.offer_start_time ;;
    }

    dimension_group: offer_end {
      type: time
      timeframes: [raw,date,month,time,time_of_day,hour_of_day,quarter,year]
      sql: ${TABLE}.offer_end_time ;;
    }

    dimension: max_offer_amount {
      type: number
      sql: ${TABLE}.max_offer_amount ;;
      value_format_name: usd
    }

    dimension: min_offer_amount {
      type: number
      sql: ${TABLE}.min_offer_amount ;;
      value_format_name: usd
    }

    dimension: negotiation_offer_num {
      type: number
      sql: ${TABLE}.negotiation_offer_num ;;
    }

    dimension: user_negotiation_offer_num {
      type: number
      sql: ${TABLE}.user_negotiation_offer_num ;;
    }

    ###measures
    measure: count {
      type: count
      drill_fields: [negotiation_id]
    }

    measure: average_offer_amount {
      type: average
      sql: ${amount} AND ${offer_start_type} = 'Offer' ;;
    }

    measure: total_number_of_events {
      type: max
      sql: ${negotiation_offer_num} ;;
    }

  }
