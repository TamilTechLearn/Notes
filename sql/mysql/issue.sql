CREATE TRIGGER `tr_tbl_post_logs_forInsert_25`
AFTER
INSERT
    ON `wb_warehouse_acutrack_post_logs_25` FOR EACH ROW BEGIN DECLARE order_status varchar(5);

SELECT
    RIGHT(bb.WB_Warehouse_From_To_ID, 3) INTO order_status
FROM
    wb_warehouse_ecommerceapisettings_postacutrack_25 aa
    LEFT JOIN wb_warehouse_ecommerceapisettings_customers bb ON aa.WB_Warehouse_ECommID = bb.WB_Warehouse_ECommApi_ID
WHERE
    aa.WB_Warehouse_POST_ID = NEW.WB_Warehouse_POST_ID;

IF(order_status != 'GET') THEN
INSERT INTO
    `wb_warehouse_triggers_order_and_ship_logs_25`(
        `log_config_id`,
        `log_post_id`,
        `log_shop_id`,
        `log_post_url`,
        `log_post_content`,
        `log_response_cnt`,
        `log_return_msg`,
        `log_order_status`,
        `log_poNumber`,
        `log_additionalPONumber`,
        `log_Warehouse_ID`,
        `log_order_address`,
        `log_orderItems`,
        `log_shippingMethod`,
        `log_created_date`,
        `log_updated_date`
    )
SELECT
    NEW.WB_Warehouse_Customer_Config_ID,
    NEW.WB_Warehouse_POST_ID,
    NEW.WB_Warehouse_Shop_ID,
    NEW.WB_Warehouse_PostURL,
    NEW.WB_Warehouse_PostContent,
    b.WB_Warehouse_ResponseContent,
    NEW.WB_Warehouse_ReturnMessage,
    NEW.WB_Warehouse_status,
    REPLACE(
        json_extract(
            TRIM(
                BOTH '"'
                FROM
                    REPLACE(
                        NEW.WB_Warehouse_PostContent,
                        '\', '' ) ), ' $.poNumber ' ), ' "', '' ), REPLACE( json_extract( TRIM( BOTH '" ' FROM REPLACE( NEW.WB_Warehouse_PostContent, ' \ ', '' ) ), ' $.additionalPONumber ' ), ' "', '' ), NEW.WB_Warehouse_ID, CONCAT( REPLACE( json_extract( TRIM( BOTH '" ' FROM REPLACE( NEW.WB_Warehouse_PostContent, ' \ ', '' ) ), ' $.shippingInfos [0].contact.firstName ' ), ' "', '' ), '\n', REPLACE( json_extract( TRIM( BOTH '" ' FROM REPLACE( NEW.WB_Warehouse_PostContent, ' \ ', '' ) ), ' $.shippingInfos [0].contact.lastName ' ), ' "', '' ), '\n', REPLACE( json_extract( TRIM( BOTH '" ' FROM REPLACE( NEW.WB_Warehouse_PostContent, ' \ ', '' ) ), ' $.shippingInfos [0].address.streetAddress1 ' ), ' "', '' ), '\n', REPLACE( json_extract( TRIM( BOTH '" ' FROM REPLACE( NEW.WB_Warehouse_PostContent, ' \ ', '' ) ), ' $.shippingInfos [0].address.streetAddress2 ' ), ' "', '' ), '\n', REPLACE( json_extract( TRIM( BOTH '" ' FROM REPLACE( NEW.WB_Warehouse_PostContent, ' \ ', '' ) ), ' $.shippingInfos [0].address.city ' ), ' "', '' ), '\n', REPLACE( json_extract( TRIM( BOTH '" ' FROM REPLACE( NEW.WB_Warehouse_PostContent, ' \ ', '' ) ), ' $.shippingInfos [0].address.country ' ), ' "', '' ), '\n', REPLACE( json_extract( TRIM( BOTH '" ' FROM REPLACE( NEW.WB_Warehouse_PostContent, ' \ ', '' ) ), ' $.shippingInfos [0].address.postalCode ' ), ' "', '' ), '\n', REPLACE( json_extract( TRIM( BOTH '" ' FROM REPLACE( NEW.WB_Warehouse_PostContent, ' \ ', '' ) ), ' $.shippingInfos [0].address.state ' ), ' "', '' ), '\n', REPLACE( json_extract( TRIM( BOTH '" ' FROM REPLACE( NEW.WB_Warehouse_PostContent, ' \ ', '' ) ), ' $.shippingInfos [0].contact.phoneNo ' ), ' "', '' ) ), json_extract( TRIM( BOTH '" ' FROM REPLACE( NEW.WB_Warehouse_PostContent, ' \ ', '' ) ), ' $.orderItems ' ), ( select WB_Warehouse_Shipping_MethodName from wb_warehouse_shipping_methods where WB_Warehouse_Status = 0 and WB_Warehouse_Shipping_Value = REPLACE( json_extract( TRIM( BOTH ' "' FROM REPLACE( NEW.WB_Warehouse_PostContent, '\', '' ) ), '$.shippingInfos[0].ServiceId' ), '" ', '' ) ), b.WB_Warehouse_updated_at, NEW.WB_Warehouse_created_at from wb_warehouse_ecommerceapisettings_postacutrack_25 b LEFT JOIN wb_warehouse_ecommerceapisettings_customers c ON c.WB_Warehouse_ECommApi_ID = b.WB_Warehouse_ECommID WHERE NEW.WB_Warehouse_POST_ID = b.WB_Warehouse_POST_ID AND NEW.WB_Warehouse_Customer_Config_ID = b.WB_Warehouse_Customer_Config_ID; ELSE INSERT INTO `wb_warehouse_triggers_order_and_ship_logs_25`( `log_config_id`, `log_post_id`, `log_shop_id`, `log_post_url`, `log_post_content`, `log_response_cnt`, `log_return_msg`, `log_order_status`, `log_poNumber`, `log_additionalPONumber`, `log_Warehouse_ID`, `log_order_address`, `log_orderItems`, `log_shippingMethod`, `log_ship_track_no`, `log_ship_track_url`, `log_created_date`, `log_updated_date` ) SELECT NEW.WB_Warehouse_Customer_Config_ID, NEW.WB_Warehouse_POST_ID, NEW.WB_Warehouse_Shop_ID, NEW.WB_Warehouse_PostURL, NEW.WB_Warehouse_PostContent, b.WB_Warehouse_ResponseContent, NEW.WB_Warehouse_ReturnMessage, NEW.WB_Warehouse_status, REPLACE( json_extract( TRIM( BOTH ' "' FROM REPLACE( b.WB_Warehouse_ResponseContent, '\', '' ) ), '$.poNumber' ), '" ', '' ), REPLACE( json_extract( TRIM( BOTH ' "' FROM REPLACE( b.WB_Warehouse_ResponseContent, '\', '' ) ), '$.additionalPONumber' ), '" ', '' ), NEW.WB_Warehouse_ID, CONCAT( REPLACE( json_extract( TRIM( BOTH ' "' FROM REPLACE( b.WB_Warehouse_ResponseContent, '\', '' ) ), '$.shippingInfos[0].contact.firstName' ), '" ', '' ), ' \ n ', REPLACE( json_extract( TRIM( BOTH ' "' FROM REPLACE( b.WB_Warehouse_ResponseContent, '\', '' ) ), '$.shippingInfos[0].contact.lastName' ), '" ', '' ), ' \ n ', REPLACE( json_extract( TRIM( BOTH ' "' FROM REPLACE( b.WB_Warehouse_ResponseContent, '\', '' ) ), '$.shippingInfos[0].address.streetAddress1' ), '" ', '' ), ' \ n ', REPLACE( json_extract( TRIM( BOTH ' "' FROM REPLACE( b.WB_Warehouse_ResponseContent, '\', '' ) ), '$.shippingInfos[0].address.streetAddress2' ), '" ', '' ), ' \ n ', REPLACE( json_extract( TRIM( BOTH ' "' FROM REPLACE( b.WB_Warehouse_ResponseContent, '\', '' ) ), '$.shippingInfos[0].address.city' ), '" ', '' ), ' \ n ', REPLACE( json_extract( TRIM( BOTH ' "' FROM REPLACE( b.WB_Warehouse_ResponseContent, '\', '' ) ), '$.shippingInfos[0].address.country' ), '" ', '' ), ' \ n ', REPLACE( json_extract( TRIM( BOTH ' "' FROM REPLACE( b.WB_Warehouse_ResponseContent, '\', '' ) ), '$.shippingInfos[0].address.postalCode' ), '" ', '' ), ' \ n ', REPLACE( json_extract( TRIM( BOTH ' "' FROM REPLACE( b.WB_Warehouse_ResponseContent, '\', '' ) ), '$.shippingInfos[0].address.state' ), '" ', '' ), ' \ n ', REPLACE( json_extract( TRIM( BOTH ' "' FROM REPLACE( b.WB_Warehouse_ResponseContent, '\', '' ) ), '$.shippingInfos[0].contact.phoneNo' ), '" ', '' ) ), json_extract( TRIM( BOTH ' "' FROM REPLACE( b.WB_Warehouse_ResponseContent, '\', '' ) ), '$.orderItems' ), ( select WB_Warehouse_Shipping_MethodName from wb_warehouse_shipping_methods where WB_Warehouse_Status = 0 and WB_Warehouse_Shipping_Value = REPLACE( json_extract( TRIM( BOTH '" ' FROM REPLACE( b.WB_Warehouse_ResponseContent, ' \ ', '' ) ), ' $.shippingInfos [0].ServiceId ' ), ' "', '' ) ), REPLACE(json_extract(TRIM(BOTH '" ' FROM REPLACE(b.WB_Warehouse_ResponseContent, ' \ ', '')), ' $.shipments [0].packageShipments [0].trackingNo '), ' "', ''), REPLACE(json_extract(TRIM(BOTH '" ' FROM REPLACE(b.WB_Warehouse_ResponseContent, ' \ ', '')), ' $.shipments [0].packageShipments [0].trackingLink '), ' "', ''), b.WB_Warehouse_updated_at, NEW.WB_Warehouse_created_at from wb_warehouse_ecommerceapisettings_postacutrack_25 b WHERE NEW.WB_Warehouse_POST_ID = b.WB_Warehouse_POST_ID AND NEW.WB_Warehouse_Customer_Config_ID = b.WB_Warehouse_Customer_Config_ID; END IF; END