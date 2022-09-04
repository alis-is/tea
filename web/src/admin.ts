import { Contract } from "./contract";

export interface IOperatorOpParams {
	owner: string,
	operator: string,
	token_id: number
}

export class AdminContract extends Contract {
	async setLock(locked: boolean) {
		const contract = await this.get_contract();
		return await contract.methodsObject.setLock(locked).send()
	}
}