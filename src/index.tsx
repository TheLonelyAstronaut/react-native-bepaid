import { NativeModules } from 'react-native';

export type PaymentResponse = {
  result: string;
  error: string;
  token: string;
  responseCode: number;
};

type BePaidType = {
  processPayment(): Promise<PaymentResponse>;
  setAmount(amount: number): void;
};

const { BePaid } = NativeModules;

export default BePaid as BePaidType;
