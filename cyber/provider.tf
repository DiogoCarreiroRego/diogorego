terraform {
  required_version = ">= 1.3.9"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.56.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = "ASIA46RMNWEGAPNRHHMK"
  secret_key = "ob5PKIem0vBJGNYq2wqMkpjLLIYjSMRLVgLe9MV9"
  token = "FwoGZXIvYXdzEEQaDJsng7wRwD9nqWGKLCK7AUi86h/GT8AvQkrpiZNWZclQnpy/zJkxxQC6CnwCnNls5wuTQN6dHzNFo7P/pYKhMp+N9ZYakKpX1OolAAj+MuZ/EcI0mOOwuHqWw0sisOKOSdWOuus+7o3NjdhOb/QZC5bKtFoIFV0MKLUs1vAmJ5Ovcvh1S0IBs2CG5an3gSijEquwTEEbAxNsyqWu1H/82G+0vcb24Vgn9NR0BeOkD5NdF/qksxDA46zKK7DD7xXAZ8Orb6sYlgmW2iIo2cbGoAYyLYdCs6KRLxv7YuDKnI7Kzqv0LPxFJ6ENQutHs130b84ujY+zSZTantgIehndWA=="
}