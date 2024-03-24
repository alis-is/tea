import fs from "fs/promises";

import { InMemorySigner } from "@taquito/signer";
import { AdminContract, Contract } from "../dist/cjs/index.js"
import { parse } from "hjson"
import { get } from "lodash-es"
import { TezosToolkit } from "@taquito/taquito";
const appHjson = parse((await fs.readFile("../app.hjson")).toString())

const ADMIN_KEY = "edsk3QoqBuvdamxouPhin7swCvkQNgq4jP5KZPbwWNnwdZpSpJiEbq"
const BOB_KEY = "edsk3RFfvaFaxbHx8BMtEW1rKQcPtDML3LXjNqMNLCzC3wLC1bWbAt"
const RPC_URL = `http://localhost:${get(appHjson, "sandbox.rpc_port", 20000)}`

const get_toolkit = async (key) => {
	const toolkit = new TezosToolkit(RPC_URL)
	toolkit.setProvider( {signer: await InMemorySigner.fromSecretKey(key)})
	return toolkit;
}

export const setup = async () => {
	const id = appHjson.id
	const { contractAddress } = JSON.parse(
		(await fs.readFile(`../deploy/sandbox-${id}.json`)).toString()
	);
	const admin = new AdminContract(await get_toolkit(ADMIN_KEY), contractAddress, { });
	const bob = new Contract(await get_toolkit(BOB_KEY), contractAddress, { });
	const bobAsAdmin = new AdminContract(await get_toolkit(BOB_KEY), contractAddress, { });
	return { bob, admin, bobAsAdmin, contractAddress }
};