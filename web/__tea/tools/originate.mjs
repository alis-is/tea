import { InMemorySigner } from "@taquito/signer"
import { TezosToolkit } from "@taquito/taquito"
import { readFile, writeFile } from "fs/promises"

const ID = process.env.ID
const DEPLOYMENT_ID = process.env.DEPLOYMENT_ID
const CREATOR_KEY = process.env.CREATOR_KEY
const contractCode = (await readFile(`../build/${ID}.tz`)).toString()
const initialStorage = (await readFile(`../build/${DEPLOYMENT_ID}-storage-${ID}.tz`)).toString()

const toolkit = new TezosToolkit(process.env.RPC)
toolkit.setProvider({ signer: new InMemorySigner(CREATOR_KEY) })

console.log(`Generating origination operation...`)
const originationOp = await toolkit.contract.originate({
	code: contractCode,
	init: initialStorage
})
console.log(`Originating contract...`)
const { address: contractAddress } = await originationOp.contract(1)

const contractTezosInfo = { contractAddress }
await writeFile(`../deploy/${DEPLOYMENT_ID}-${ID}.json`, JSON.stringify(contractTezosInfo))
