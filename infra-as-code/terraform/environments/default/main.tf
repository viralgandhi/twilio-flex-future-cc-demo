provider "twilio" {
  account_sid = var.TWILIO_ACCOUNT_SID
  username    = var.TWILIO_API_KEY
  password    = var.TWILIO_API_SECRET
}

terraform {
  required_providers {
    twilio = {
      source  = "twilio/twilio"
      version = ">=0.4.0"
    }
  }

  required_version = ">= 1.1.0"

  backend "local" {}
}

module "studio" {
  source                        = "../../modules/studio"
  workflow_sid_assign_to_anyone = module.taskrouter.workflow_sid_assign_to_anyone
  workflow_sid_chat_transfer    = module.taskrouter.workflow_sid_chat_transfer
  workflow_sid_callback         = module.taskrouter.workflow_sid_callback
  workflow_sid_internal_call    = module.taskrouter.workflow_sid_internal_call
  chat_channel_sid              = module.taskrouter.chat_channel_sid
  voice_channel_sid             = module.taskrouter.voice_channel_sid
  serverless_domain             = var.SERVERLESS_DOMAIN
  serverless_sid                = var.SERVERLESS_SID
  serverless_env_sid            = var.SERVERLESS_ENV_SID
}

module "taskrouter" {
  source = "../../modules/taskrouter"
}
