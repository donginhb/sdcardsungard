-- Start of generated script for 10.253.42.204-db2inst1-WLGL (db2inst1)
--  Jan-14-2011 at 15:59:43

ALTER TABLE SCHOOLREP.WL_EQP_COLCHECK_CONFIG
  ADD notify_type        VARCHAR(20)
  ADD notify_person_ids  VARCHAR(200);

#SYNC 10;

COMMENT ON SCHOOLREP.WL_EQP_COLCHECK_CONFIG
 (notify_type IS '通知类型(邮件email；短信mobilemsg；)',
  notify_person_ids IS '通知人员，可以多个'
 );

#SYNC 20;



-- End of generated script for 10.253.42.204-db2inst1-WLGL (db2inst1)