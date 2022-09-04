import test from "ava";
import { setup } from "./base.mjs"

test.serial("increment (locked - admin)", async (t) => {
	const { admin } = await setup();
	await (await admin.setLock(true)).confirmation() // reset
	let storage = (await admin.get_contract_storage())
	const initialValue = storage.state.toNumber()
	await (await admin.increment(2)).confirmation()
	storage = (await admin.get_contract_storage())
	t.is(storage.state.toNumber(), initialValue + 2)
});

test.serial("increment (locked - not admin)", async (t) => {
	const { bob, admin } = await setup();
	await (await admin.setLock(true)).confirmation() // reset
	let storage = (await bob.get_contract_storage())
	const initialValue = storage.state.toNumber()
	try {
		await (await bob.increment(2)).confirmation()
		t.fail("Should not be able to increment if locked and not admin")
	} catch (err) {
		t.true(err.toString().includes("not admin"))
	}
	storage = (await bob.get_contract_storage())
	t.is(storage.state.toNumber(), initialValue)
});

test.serial("increment (not locked - not admin)", async (t) => {
	const { bob, admin } = await setup();
	await (await admin.setLock(false)).confirmation() // reset
	let storage = (await bob.get_contract_storage())
	const initialValue = storage.state.toNumber()
	await (await bob.increment(3)).confirmation()
	storage = (await bob.get_contract_storage())
	t.is(storage.state.toNumber(), initialValue + 3)
});

test.serial("decrement (locked - admin)", async (t) => {
	const { admin } = await setup();
	await (await admin.setLock(true)).confirmation() // reset
	let storage = (await admin.get_contract_storage())
	const initialValue = storage.state.toNumber()
	await (await admin.decrement(2)).confirmation()
	storage = (await admin.get_contract_storage())
	t.is(storage.state.toNumber(), initialValue - 2)
});

test.serial("decrement (locked - not admin)", async (t) => {
	const { bob, admin } = await setup();
	await (await admin.setLock(true)).confirmation() // reset
	let storage = (await bob.get_contract_storage())
	const initialValue = storage.state.toNumber()
	try {
		await (await bob.decrement(2)).confirmation()
		t.fail("Should not be able to decrement if locked and not admin")
	} catch (err) {
		t.true(err.toString().includes("not admin"))
	}
	storage = (await bob.get_contract_storage())
	t.is(storage.state.toNumber(), initialValue)
});

test.serial("decrement (not locked - not admin)", async (t) => {
	const { bob, admin } = await setup();
	await (await admin.setLock(false)).confirmation() // reset
	let storage = (await bob.get_contract_storage())
	const initialValue = storage.state.toNumber()
	await (await bob.decrement(3)).confirmation()
	storage = (await bob.get_contract_storage())
	t.is(storage.state.toNumber(), initialValue - 3)
});
