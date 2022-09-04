import test from "ava";
import { setup } from "./base.mjs"

test.serial("setLock", async (t) => {
	const { admin } = await setup();
	await (await admin.setLock(true)).confirmation() // reset

	await (await admin.setLock(false)).confirmation()
	let storage = (await admin.get_contract_storage())
	t.is(storage.locked, false)
	await (await admin.setLock(true)).confirmation()
	storage = (await admin.get_contract_storage())
	t.is(storage.locked, true)
});

test.serial("setLock (not admin)", async (t) => {
	const { bobAsAdmin } = await setup();
	try {
		await (await bobAsAdmin.setLock(true)).confirmation() // reset
		t.fail("Should not be able to adjust lock if not admin")
	} catch (err) {
		t.true(err.toString().includes("not admin"))
	}
});
