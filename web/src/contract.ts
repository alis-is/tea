import { TezosToolkit, Signer, Wallet, ContractAbstraction } from "@taquito/taquito";
//import { Tzip12Module, tzip12, Tzip12ContractAbstraction } from "@taquito/tzip12";
import { Tzip16Module, tzip16, Tzip16ContractAbstraction } from "@taquito/tzip16";
import { RpcClientInterface } from "@taquito/rpc";

export interface IOperatorOpParams {
	owner: string,
	operator: string,
	token_id: number
}

export class Contract {
	private toolkit: TezosToolkit
	private contractAddr: string

	constructor(toolkit: TezosToolkit, contractAddr: string, options: {} = {}) {
		// toolkit.addExtension(new Tzip12Module());
		toolkit.addExtension(new Tzip16Module());

		this.toolkit = toolkit
		this.contractAddr = contractAddr
	}

	async get_contract(): Promise<ContractAbstraction<Wallet> & { /*tzip12: () => Tzip12ContractAbstraction,*/ tzip16: () => Tzip16ContractAbstraction }> {
		return await this.toolkit.wallet.at(this.contractAddr, tzip16 /* compose(tzip12, tzip16) */)
	}

	async get_rpc(): Promise<RpcClientInterface> {
		return this.toolkit.rpc
	}

	get ContractAddress() {
		return this.contractAddr
	}

	async get_contract_storage() {
		return (await this.get_contract()).storage()
	}

	async get_addr() {
		try {
			return await this.toolkit.wallet.pkh()
		} catch {
			return await this.toolkit.signer.publicKeyHash()
		}
	}

	async increment(n: number) {
		const contract = await this.get_contract();
		return await contract.methodsObject.increment(n).send()
	}

	async decrement(n: number) {
		const contract = await this.get_contract();
		return await contract.methodsObject.decrement(n).send()
	}
}