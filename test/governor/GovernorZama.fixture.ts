import { ethers } from 'hardhat';

import { Comp } from '../../types';
import type { GovernorZama, Timelock } from '../../types';
import { getSigners } from '../signers';

export async function deployGovernorZamaFixture(
  compContract: Comp,
): Promise<{ governor: GovernorZama; timelock: Timelock }> {
  const signers = await getSigners();

  const timelockFactory = await ethers.getContractFactory('Timelock');
  const timelock = await timelockFactory.connect(signers.alice).deploy(signers.alice.address, 60 * 60 * 24 * 2);

  await timelock.waitForDeployment();

  const governorFactory = await ethers.getContractFactory('GovernorZama');
  const governor = await governorFactory
    .connect(signers.alice)
    .deploy(timelock.getAddress(), compContract.getAddress(), signers.alice.address);
  await governor.waitForDeployment();

  return { governor, timelock };
}
