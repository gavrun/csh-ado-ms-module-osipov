select cast(serverproperty('EngineEdition') as int)
go
IF db_id(N'CustomerManager2') IS NOT NULL SELECT 1 ELSE SELECT Count(*) FROM sys.databases WHERE [name]=N'CustomerManager2'
go

SELECT Count(*)
FROM INFORMATION_SCHEMA.TABLES AS t
WHERE t.TABLE_SCHEMA + '.' + t.TABLE_NAME IN ('dbo.Customers','dbo.Orders')
    OR t.TABLE_NAME = 'EdmMetadata'
go
SELECT 
    [GroupBy1].[A1] AS [C1]
    FROM ( SELECT 
        COUNT(1) AS [A1]
        FROM [dbo].[__MigrationHistory] AS [Extent1]
    )  AS [GroupBy1]
go
SELECT TOP (1) 
    [Extent1].[Id] AS [Id], 
    [Extent1].[ModelHash] AS [ModelHash]
    FROM [dbo].[EdmMetadata] AS [Extent1]
    ORDER BY [Extent1].[Id] DESC
go
SELECT 
    [Extent1].[OrderId] AS [OrderId], 
    [Extent1].[ProductName] AS [ProductName], 
    [Extent1].[Description] AS [Description], 
    [Extent1].[Quantity] AS [Quantity], 
    [Extent1].[PurchaseDate] AS [PurchaseDate], 
    [Extent1].[Customer_CustomerId] AS [Customer_CustomerId]
    FROM [dbo].[Orders] AS [Extent1]
go
SELECT 
    [Extent1].[CustomerId] AS [CustomerId], 
    [Extent1].[FirstName] AS [FirstName], 
    [Extent1].[LastName] AS [LastName], 
    [Extent1].[Email] AS [Email], 
    [Extent1].[Age] AS [Age], 
    [Extent1].[Photo] AS [Photo]
    FROM [dbo].[Customers] AS [Extent1]
go
SELECT 
    [Extent1].[CustomerId] AS [CustomerId], 
    [Extent1].[FirstName] AS [FirstName], 
    [Extent1].[LastName] AS [LastName], 
    [Extent1].[Email] AS [Email], 
    [Extent1].[Age] AS [Age], 
    [Extent1].[Photo] AS [Photo]
    FROM [dbo].[Customers] AS [Extent1]
    ORDER BY [Extent1].[FirstName] ASC
go
SELECT 
    [Extent1].[CustomerId] AS [CustomerId], 
    [Extent1].[FirstName] AS [FirstName], 
    [Extent1].[LastName] AS [LastName], 
    [Extent1].[Email] AS [Email], 
    [Extent1].[Age] AS [Age], 
    [Extent1].[Photo] AS [Photo]
    FROM [dbo].[Customers] AS [Extent1]
go
SET DEADLOCK_PRIORITY -10
go
SELECT target_data
									FROM sys.dm_xe_session_targets xet WITH(nolock)
									JOIN sys.dm_xe_sessions xes WITH(nolock)
									ON xes.address = xet.event_session_address
									WHERE xes.name = 'telemetry_xevents'
									AND xet.target_name = 'ring_buffer'
go
SET DEADLOCK_PRIORITY -10
go
if exists(select * from sys.server_event_sessions where name='telemetry_xevents')
	drop event session telemetry_xevents on server

create event session telemetry_xevents on server
 ADD EVENT [sqlserver].[error_reported]
(
WHERE severity >= 16
or (error_number = 18456
    or error_number = 17803 or error_number = 701 or error_number = 802 or error_number = 8645 or error_number = 8651
    or error_number = 8657 or error_number = 8902 or error_number = 41354 or error_number = 41355 or error_number = 41367
    or error_number = 41384 or error_number = 41336 or error_number = 41309 or error_number = 41312 or error_number = 41313
    or error_number = 33065 or error_number = 33066)
),

 ADD EVENT [sqlserver].[missing_column_statistics],

 ADD EVENT [sqlserver].[missing_join_predicate],

 ADD EVENT [sqlserver].[server_memory_change],

 ADD EVENT [sqlserver].[stretch_database_disable_completed],

 ADD EVENT [sqlserver].[stretch_database_enable_completed],

 ADD EVENT [sqlserver].[stretch_database_reauthorize_completed],

 ADD EVENT [sqlserver].[stretch_index_reconciliation_codegen_completed],

 ADD EVENT [sqlserver].[stretch_remote_column_execution_completed],

 ADD EVENT [sqlserver].[stretch_remote_column_reconciliation_codegen_completed],

 ADD EVENT [sqlserver].[stretch_remote_index_execution_completed],

 ADD EVENT [sqlserver].[stretch_table_codegen_completed],

 ADD EVENT [sqlserver].[stretch_table_alter_ddl],

 ADD EVENT [sqlserver].[stretch_table_create_ddl],

 ADD EVENT [sqlserver].[stretch_table_predicate_not_specified],

 ADD EVENT [sqlserver].[stretch_table_predicate_specified],

 ADD EVENT [sqlserver].[stretch_table_remote_creation_completed],

 ADD EVENT [sqlserver].[stretch_table_row_migration_results_event],

 ADD EVENT [sqlserver].[stretch_table_row_unmigration_results_event],

 ADD EVENT [sqlserver].[stretch_table_data_reconciliation_results_event],

 ADD EVENT [sqlserver].[stretch_table_unprovision_completed],

 ADD EVENT [sqlserver].[stretch_table_validation_error],

 ADD EVENT [sqlserver].[stretch_table_hinted_admin_update_event],

 ADD EVENT [sqlserver].[stretch_table_hinted_admin_delete_event],

 ADD EVENT [sqlserver].[stretch_table_query_error],

 ADD EVENT [sqlserver].[stretch_remote_error],

 ADD EVENT [sqlserver].[stretch_query_telemetry],

 ADD EVENT [sqlserver].[temporal_ddl_system_versioning],

 ADD EVENT [sqlserver].[temporal_dml_transaction_fail],

 ADD EVENT [sqlserver].[temporal_ddl_period_add],

 ADD EVENT [sqlserver].[temporal_ddl_period_drop],

 ADD EVENT [sqlserver].[temporal_ddl_schema_check_fail],

 ADD EVENT [sqlserver].[data_masking_ddl_column_definition],

 ADD EVENT [sqlserver].[data_masking_traffic],

 ADD EVENT [sqlserver].[data_masking_traffic_masked_only],

 ADD EVENT [sqlserver].[data_classification_ddl_column_definition],

 ADD EVENT [sqlserver].[data_classification_traffic],

 ADD EVENT [sqlserver].[data_classification_auditing_traffic],

 ADD EVENT [sqlserver].[always_encrypted_query_count],

 ADD EVENT [sqlserver].[rls_query_count],

 ADD EVENT [sqlserver].[auto_stats],

 ADD EVENT [sqlserver].[database_cmptlevel_change],

 ADD EVENT [sqlserver].[database_created],

 ADD EVENT [sqlserver].[database_dropped],

 ADD EVENT [sqlserver].[reason_many_foreign_keys_operator_not_used],

 ADD EVENT [sqlserver].[interleaved_exec_status],

 ADD EVENT [sqlserver].[table_variable_deferred_compilation],

 ADD EVENT [sqlserver].[graph_match_query_compiled],

 ADD EVENT [sqlserver].[approximate_count_distinct_query_compiled],

 ADD EVENT [sqlserver].[query_ce_feedback_telemetry],

 ADD EVENT [sqlserver].[query_feedback_analysis],

 ADD EVENT [sqlserver].[query_feedback_validation],

 ADD EVENT [sqlserver].[tsql_feature_usage_tracking],

 ADD EVENT [sqlserver].[parameter_sensitive_plan_optimization],

 ADD EVENT [sqlserver].[login_protocol_count],

 ADD EVENT [sqlserver].[column_store_index_build_low_memory],

 ADD EVENT [sqlserver].[column_store_index_build_throttle],

 ADD EVENT [sqlserver].[columnstore_delete_buffer_flush_failed],

 ADD EVENT [sqlserver].[columnstore_delta_rowgroup_closed],

 ADD EVENT [sqlserver].[columnstore_index_reorg_failed],

 ADD EVENT [sqlserver].[columnstore_log_exception],

 ADD EVENT [sqlserver].[columnstore_rowgroup_merge_failed],

 ADD EVENT [sqlserver].[columnstore_tuple_mover_delete_buffer_truncate_timed_out],

 ADD EVENT [sqlserver].[columnstore_tuple_mover_end_compress],

 ADD EVENT [sqlserver].[query_memory_grant_blocking],

 ADD EVENT [sqlserver].[natively_compiled_module_inefficiency_detected],

 ADD EVENT [sqlserver].[natively_compiled_proc_slow_parameter_passing],

 ADD EVENT [sqlserver].[xtp_alter_table],

 ADD EVENT [sqlserver].[xtp_db_delete_only_mode_updatedhktrimlsn],

 ADD EVENT [sqlserver].[xtp_stgif_container_added],

 ADD EVENT [sqlserver].[xtp_stgif_container_deleted],

 ADD EVENT [xtpcompile].[cl_duration],

 ADD EVENT [xtpengine].[xtp_physical_db_restarted],

 ADD EVENT [xtpengine].[xtp_db_delete_only_mode_enter],

 ADD EVENT [xtpengine].[xtp_db_delete_only_mode_update],

 ADD EVENT [xtpengine].[xtp_db_delete_only_mode_exit],

 ADD EVENT [xtpengine].[parallel_alter_stats],

 ADD EVENT [xtpengine].[serial_alter_stats],

 ADD EVENT [sqlserver].[json_function_compiled]
(
ACTION ([database_id])
),

 ADD EVENT [sqlserver].[string_escape_compiled]
(
ACTION ([database_id])
),

 ADD EVENT [sqlserver].[window_function_used]
(
ACTION ([database_id])
),

 ADD EVENT [sqlserver].[sequence_function_used]
(
ACTION ([database_id])
),

 ADD EVENT [qds].[query_store_db_diagnostics],

 ADD EVENT [sqlserver].[index_defragmentation],

 ADD EVENT [sqlserver].[create_index_event],

 ADD EVENT [sqlserver].[index_build_error_event],

 ADD EVENT [sqlserver].[alter_column_event],

 ADD EVENT [sqlserver].[cardinality_estimation_version_usage],

 ADD EVENT [sqlserver].[query_optimizer_compatibility_level_hint_usage],

 ADD EVENT [sqlserver].[query_optimizer_nullable_scalar_agg_iv_update],

 ADD EVENT [sqlserver].[query_tsql_scalar_udf_inlined],

 ADD EVENT [sqlserver].[tsql_scalar_udf_not_inlineable],

 ADD EVENT [sqlserver].[tsql_scalar_udf_inlining_threshold],

 ADD EVENT [sqlserver].[memory_grant_feedback_persistence_update],

 ADD EVENT [sqlserver].[memory_grant_feedback_percentile_grant],

 ADD EVENT [sqlserver].[recovery_checkpoint_stats],

 ADD EVENT [sqlserver].[multistep_execution]
(
ACTION ([database_id])
),

 ADD EVENT [sqlserver].[fulltext_filter_usage],

 ADD EVENT [sqlserver].[tx_commit_abort_stats],

 ADD EVENT [sqlserver].[ledger_transaction_count],

 ADD EVENT [sqlserver].[ledger_digest_upload_success],

 ADD EVENT [sqlserver].[resumable_add_constraint_executed],

 ADD EVENT [sqlserver].[repl_p2p_conflict_detection_policy_status],

 ADD EVENT [sqlserver].[server_start_stop]
add target package0.ring_buffer
(set occurrence_number = 100)
with
(
	MAX_DISPATCH_LATENCY = 120 SECONDS,
	MAX_MEMORY = 4 MB,
	startup_state = on
)
if not exists (select * from sys.dm_xe_sessions where name = 'telemetry_xevents')
	alter event session telemetry_xevents on server state=start

go
SELECT 
    [Extent1].[CustomerId] AS [CustomerId], 
    [Extent1].[FirstName] AS [FirstName], 
    [Extent1].[LastName] AS [LastName], 
    [Extent1].[Email] AS [Email], 
    [Extent1].[Age] AS [Age], 
    [Extent1].[Photo] AS [Photo]
    FROM [dbo].[Customers] AS [Extent1]
go
SELECT 
    [Extent1].[CustomerId] AS [CustomerId], 
    [Extent1].[FirstName] AS [FirstName], 
    [Extent1].[LastName] AS [LastName], 
    [Extent1].[Email] AS [Email], 
    [Extent1].[Age] AS [Age], 
    [Extent1].[Photo] AS [Photo]
    FROM [dbo].[Customers] AS [Extent1]
go
