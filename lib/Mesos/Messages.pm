# Generated by the protocol buffer compiler (protoc-perl) DO NOT EDIT!
# source: /tmp/4ekdQYLCM_



use strict;
use warnings;

use Google::ProtocolBuffers;
{
    unless (Mesos::TaskState->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_enum(
            'Mesos::TaskState',
            [
               ['TASK_STAGING', 6],
               ['TASK_STARTING', 0],
               ['TASK_RUNNING', 1],
               ['TASK_FINISHED', 2],
               ['TASK_FAILED', 3],
               ['TASK_KILLED', 4],
               ['TASK_LOST', 5],

            ]
        );
    }
    
    unless (Mesos::Value::Type->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_enum(
            'Mesos::Value::Type',
            [
               ['SCALAR', 0],
               ['RANGES', 1],
               ['SET', 2],
               ['TEXT', 3],

            ]
        );
    }
    
    unless (Mesos::Status->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_enum(
            'Mesos::Status',
            [
               ['DRIVER_NOT_STARTED', 1],
               ['DRIVER_RUNNING', 2],
               ['DRIVER_ABORTED', 3],
               ['DRIVER_STOPPED', 4],

            ]
        );
    }
    
    unless (Mesos::TaskStatus->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::TaskStatus',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    'Mesos::TaskID', 
                    'task_id', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    'Mesos::TaskState', 
                    'state', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'data', 3, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'message', 4, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::SlaveID', 
                    'slave_id', 5, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_DOUBLE(), 
                    'timestamp', 6, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::SlaveID->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::SlaveID',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'value', 1, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::TaskInfo->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::TaskInfo',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'name', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    'Mesos::TaskID', 
                    'task_id', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    'Mesos::SlaveID', 
                    'slave_id', 3, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'Mesos::Resource', 
                    'resources', 4, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::ExecutorInfo', 
                    'executor', 5, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'data', 6, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::CommandInfo', 
                    'command', 7, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::ContainerID->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::ContainerID',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'value', 1, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Value::Scalar->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Value::Scalar',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_DOUBLE(), 
                    'value', 1, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::SlaveInfo->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::SlaveInfo',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'hostname', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'webui_hostname', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'Mesos::Resource', 
                    'resources', 3, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_INT32(), 
                    'webui_port', 4, 8081
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'Mesos::Attribute', 
                    'attributes', 5, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::SlaveID', 
                    'id', 6, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BOOL(), 
                    'checkpoint', 7, 0
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_INT32(), 
                    'port', 8, 5051
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Value::Text->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Value::Text',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'value', 1, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::OfferID->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::OfferID',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'value', 1, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Attribute->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Attribute',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'name', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    'Mesos::Value::Type', 
                    'type', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::Value::Scalar', 
                    'scalar', 3, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::Value::Ranges', 
                    'ranges', 4, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::Value::Text', 
                    'text', 5, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::Value::Set', 
                    'set', 6, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Value->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Value',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    'Mesos::Value::Type', 
                    'type', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::Value::Scalar', 
                    'scalar', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::Value::Ranges', 
                    'ranges', 3, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::Value::Set', 
                    'set', 4, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::Value::Text', 
                    'text', 5, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Offer->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Offer',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    'Mesos::OfferID', 
                    'id', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    'Mesos::FrameworkID', 
                    'framework_id', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    'Mesos::SlaveID', 
                    'slave_id', 3, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'hostname', 4, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'Mesos::Resource', 
                    'resources', 5, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'Mesos::ExecutorID', 
                    'executor_ids', 6, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'Mesos::Attribute', 
                    'attributes', 7, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::FrameworkInfo->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::FrameworkInfo',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'user', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'name', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::FrameworkID', 
                    'id', 3, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_DOUBLE(), 
                    'failover_timeout', 4, 0.0
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BOOL(), 
                    'checkpoint', 5, 0
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'role', 6, "*"
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Environment::Variable->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Environment::Variable',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'name', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'value', 2, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Value::Set->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Value::Set',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'item', 1, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Request->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Request',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::SlaveID', 
                    'slave_id', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'Mesos::Resource', 
                    'resources', 2, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Parameters->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Parameters',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'Mesos::Parameter', 
                    'parameter', 1, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::FrameworkID->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::FrameworkID',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'value', 1, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Parameter->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Parameter',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'key', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'value', 2, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::ExecutorInfo->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::ExecutorInfo',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    'Mesos::ExecutorID', 
                    'executor_id', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'data', 4, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'Mesos::Resource', 
                    'resources', 5, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    'Mesos::CommandInfo', 
                    'command', 7, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::FrameworkID', 
                    'framework_id', 8, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'name', 9, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'source', 10, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::ResourceStatistics->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::ResourceStatistics',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_DOUBLE(), 
                    'timestamp', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_DOUBLE(), 
                    'cpus_user_time_secs', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_DOUBLE(), 
                    'cpus_system_time_secs', 3, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_DOUBLE(), 
                    'cpus_limit', 4, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT64(), 
                    'mem_rss_bytes', 5, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT64(), 
                    'mem_limit_bytes', 6, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'cpus_nr_periods', 7, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'cpus_nr_throttled', 8, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_DOUBLE(), 
                    'cpus_throttled_time_secs', 9, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT64(), 
                    'mem_file_bytes', 10, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT64(), 
                    'mem_anon_bytes', 11, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT64(), 
                    'mem_mapped_file_bytes', 12, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Resource->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Resource',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'name', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    'Mesos::Value::Type', 
                    'type', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::Value::Scalar', 
                    'scalar', 3, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::Value::Ranges', 
                    'ranges', 4, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::Value::Set', 
                    'set', 5, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'role', 6, "*"
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::ResourceUsage->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::ResourceUsage',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    'Mesos::SlaveID', 
                    'slave_id', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    'Mesos::FrameworkID', 
                    'framework_id', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::ExecutorID', 
                    'executor_id', 3, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'executor_name', 4, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::TaskID', 
                    'task_id', 5, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::ResourceStatistics', 
                    'statistics', 6, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::CommandInfo::URI->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::CommandInfo::URI',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'value', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BOOL(), 
                    'executable', 2, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::TaskID->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::TaskID',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'value', 1, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Value::Range->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Value::Range',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT64(), 
                    'begin', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT64(), 
                    'end', 2, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::CommandInfo->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::CommandInfo',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'Mesos::CommandInfo::URI', 
                    'uris', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    'Mesos::Environment', 
                    'environment', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'value', 3, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Credential->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Credential',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'principal', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_BYTES(), 
                    'secret', 2, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::ExecutorID->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::ExecutorID',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'value', 1, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Filters->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Filters',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_DOUBLE(), 
                    'refuse_seconds', 1, 5.0
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Value::Ranges->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Value::Ranges',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'Mesos::Value::Range', 
                    'range', 1, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::MasterInfo->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::MasterInfo',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'id', 1, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'ip', 2, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_REQUIRED(), 
                    Google::ProtocolBuffers::Constants::TYPE_UINT32(), 
                    'port', 3, 5050
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'pid', 4, undef
                ],
                [
                    Google::ProtocolBuffers::Constants::LABEL_OPTIONAL(), 
                    Google::ProtocolBuffers::Constants::TYPE_STRING(), 
                    'hostname', 5, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

    unless (Mesos::Environment->can('_pb_fields_list')) {
        Google::ProtocolBuffers->create_message(
            'Mesos::Environment',
            [
                [
                    Google::ProtocolBuffers::Constants::LABEL_REPEATED(), 
                    'Mesos::Environment::Variable', 
                    'variables', 1, undef
                ],

            ],
            { 'create_accessors' => 1,  }
        );
    }

}
1;
