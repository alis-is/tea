import fs from "fs/promises";

import { InMemorySigner } from "@taquito/signer";
import { AdminContract, Contract } from "../dist/cjs/index.js"
import { parse } from "hjson"
import { get } from "lodash-es"
const appHjson = parse((await fs.readFile("../app.hjson")).toString())

const ADMIN_KEY = "edsk3QoqBuvdamxouPhin7swCvkQNgq4jP5KZPbwWNnwdZpSpJiEbq"
const BOB_KEY = "edsk3RFfvaFaxbHx8BMtEW1rKQcPtDML3LXjNqMNLCzC3wLC1bWbAt"
const RPC_URL = `http://localhost:${get(appHjson, "sandbox.rpc_port", 20000)}`

export const setup = async () => {
	const id = appHjson.id
	const { contractAddress } = JSON.parse(
		(await fs.readFile(`../deploy/sandbox-${id}.json`)).toString()
	);
	const admin = new AdminContract(RPC_URL, contractAddress, { test: true, signer: await InMemorySigner.fromSecretKey(ADMIN_KEY) });
	const bob = new Contract(RPC_URL, contractAddress, { test: true, signer: await InMemorySigner.fromSecretKey(BOB_KEY) });
	const bobAsAdmin = new AdminContract(RPC_URL, contractAddress, { test: true, signer: await InMemorySigner.fromSecretKey(BOB_KEY) });
	return { bob, admin, bobAsAdmin, contractAddress }
};