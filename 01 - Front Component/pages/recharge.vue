<template>
    <div class="recharge-page-container">
      <div class="recharge-card">
        <h1 class="recharge-title">Recharge Your Balance</h1>
        <p class="recharge-subtitle">Add funds to your account using your credit card</p>
  
        <div class="form-section">
          <label for="recharge-amount" class="form-label">Recharge Amount</label>
          <div class="amount-input-group">
            <span class="currency-symbol">$</span>
            <input
              id="recharge-amount"
              v-model.number="rechargeAmount"
              type="number"
              placeholder="Enter amount"
              class="amount-input"
              @focus="clearSelectedPreset"
            />
          </div>
          <div class="amount-presets">
            <button
              v-for="amount in presetAmounts"
              :key="amount"
              :class="{ 'preset-button': true, 'selected': rechargeAmount === amount }"
              @click="selectPreset(amount)"
            >
              ${{ amount }}
            </button>
          </div>
        </div>
  
        <div class="form-section">
          <h2 class="form-section-title">Credit Card Information</h2>
          <label for="card-number" class="form-label">Card Number</label>
          <input
            id="card-number"
            v-model="cardNumber"
            type="text"
            placeholder="1234 5678 9012 3456"
            class="form-input"
            @input="formatCardNumber"
            maxlength="19"
          />
  
          <div class="form-row">
            <div class="form-group expiry-date-group">
              <label for="expiry-date" class="form-label">Expiry Date</label>
              <input
                id="expiry-date"
                v-model="expiryDate"
                type="text"
                placeholder="MM/YY"
                class="form-input"
                @input="formatExpiryDate"
                maxlength="5"
              />
            </div>
            <div class="form-group cvc-group">
              <label for="cvv" class="form-label">CVV</label>
              <input
                id="cvv"
                v-model="cvv"
                type="text"
                placeholder="123"
                class="form-input"
                maxlength="4"
              />
            </div>
          </div>
  
          <label for="cardholder-name" class="form-label">Cardholder Name</label>
          <input
            id="cardholder-name"
            v-model="cardholderName"
            type="text"
            placeholder="John Doe"
            class="form-input"
          />
        </div>
  
        <div class="secure-payment-info">
          <svg
            class="secure-icon"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            fill="currentColor"
          >
            <path d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm-1 6h2v2h-2V7zm0 4h2v6h-2v-6z" />
          </svg>
          <p>
            <span class="secure-text">Secure Payment</span><br />
            Your payment information is encrypted and secure. We never store your credit card details.
          </p>
        </div>
  
        <div class="action-buttons">
          <button class="recharge-button" @click="rechargeBalance">Recharge Balance</button>
          <button class="cancel-button" @click="cancelRecharge">Cancel</button>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
import { useState } from '#app'// adjust if yours is imported differently
import { useRouter } from 'vue-router'

const userBalance = useState('userBalance', () => 0)
const router = useRouter()

// Form fields
const rechargeAmount = ref(null)
const presetAmounts = [25, 50, 100, 200]
const cardNumber = ref('')
const expiryDate = ref('')
const cvv = ref('')
const cardholderName = ref('')

const client = useSanctumClient()

// Methods
function selectPreset(amount) {
  rechargeAmount.value = amount
}

function clearSelectedPreset() {
}

function formatCardNumber(event) {
  let value = event.target.value.replace(/\D/g, '')
  let formattedValue = ''
  for (let i = 0; i < value.length; i++) {
    if (i > 0 && i % 4 === 0) {
      formattedValue += ' '
    }
    formattedValue += value[i]
  }
  cardNumber.value = formattedValue
}

function formatExpiryDate(event) {
  let value = event.target.value.replace(/\D/g, '')
  let formattedValue = value.length > 2
    ? value.substring(0, 2) + '/' + value.substring(2, 4)
    : value
  expiryDate.value = formattedValue
}

async function rechargeBalance() {
  try {
    if (!rechargeAmount.value || rechargeAmount.value <= 0) {
      alert('Please enter a valid amount.')
      return
    }

    // Send POST to backend
    const response = await client('/api/recharge', {
      method: 'POST',
      body: { amount: rechargeAmount.value },
      credentials: 'include'
    })

    // Update balance locally
    userBalance.value = response.new_balance
    alert(` ${response.message} New balance: $${response.new_balance}`)
    router.push('/profile')
  } catch (error) {
    console.error('Recharge failed:', error)
    alert('Failed to recharge balance. Please try again.')
  }
}

function cancelRecharge() {
  alert('Recharge cancelled.')
  router.back()
}
</script>

  
  <style scoped>
  /* Basic Reset & Body Styling for dark background */
  body {
    margin: 0;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    background-color: #1a1a1a; /* Dark background */
    color: #e0e0e0; /* Light text for dark background */
  }
  
  .recharge-page-container {
    display: flex;
    justify-content: center;
    align-items: flex-start; /* Align to top, not center vertically */
    min-height: 100vh;
    padding: 40px 20px; /* Add some padding around the card */
    box-sizing: border-box;
  }
  
  .recharge-card {
    background-color: #2a2a2a; /* Slightly lighter dark for the card */
    border-radius: 12px;
    padding: 40px;
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
    width: 100%;
    max-width: 500px;
    box-sizing: border-box;
  }
  
  .recharge-title {
    font-size: 2.2em;
    font-weight: 700;
    color: #ffffff;
    margin-bottom: 8px;
    text-align: center;
  }
  
  .recharge-subtitle {
    font-size: 1em;
    color: #b0b0b0;
    margin-bottom: 30px;
    text-align: center;
  }
  
  .form-section {
    margin-bottom: 25px;
  }
  
  .form-section-title {
    font-size: 1.1em;
    font-weight: 600;
    color: #ffffff;
    margin-bottom: 20px;
    padding-top: 15px; /* Spacing from previous section */
    border-top: 1px solid #3c3c3c; /* Subtle separator line */
  }
  
  .form-label {
    display: block;
    font-size: 0.9em;
    color: #c0c0c0;
    margin-bottom: 8px;
    font-weight: 500;
  }
  
  .amount-input-group {
    display: flex;
    align-items: center;
    background-color: #3a3a3a;
    border-radius: 8px;
    border: 2px solid #5a5a5a;
    padding: 10px 15px;
    margin-bottom: 15px;
    transition: border-color 0.2s ease;
  }
  
  .amount-input-group:focus-within {
    border-color: #6a9aff; /* Highlight on focus */
  }
  
  .currency-symbol {
    color: #909090;
    font-size: 1.2em;
    margin-right: 8px;
  }
  
  .amount-input {
    flex-grow: 1;
    background: none;
    border: none;
    color: #ffffff;
    font-size: 1.2em;
    padding: 0;
    outline: none; /* Remove default focus outline */
  }
  
  /* Hide number input arrows */
  input[type="number"]::-webkit-outer-spin-button,
  input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
  }
  input[type="number"] {
    -moz-appearance: textfield;
  }
  
  .amount-presets {
    display: flex;
    gap: 10px;
    margin-bottom: 25px;
  }
  
  .preset-button {
    background-color: #4a4a4a;
    color: #e0e0e0;
    border: 1px solid #5a5a5a;
    border-radius: 6px;
    padding: 10px 18px;
    font-size: 0.95em;
    cursor: pointer;
    transition: background-color 0.2s ease, border-color 0.2s ease;
  }
  
  .preset-button:hover {
    background-color: #5a5a5a;
  }
  
  .preset-button.selected {
    background-color: #6a9aff; /* Blue for selected */
    border-color: #6a9aff;
    color: #ffffff;
    font-weight: 600;
  }
  
  .form-input {
    width: 100%;
    padding: 12px 15px;
    background-color: #3a3a3a;
    border: 2px solid #5a5a5a;
    border-radius: 8px;
    color: #ffffff;
    font-size: 1em;
    box-sizing: border-box;
    margin-bottom: 20px;
    outline: none;
    transition: border-color 0.2s ease;
  }
  
  .form-input:focus {
    border-color: #6a9aff;
  }
  
  .form-row {
    display: flex;
    gap: 20px;
    margin-bottom: 20px;
  }
  
  .form-group {
    flex: 1;
  }
  
  .secure-payment-info {
    display: flex;
    align-items: flex-start; /* Align text to top of icon */
    background-color: #3a3a3a;
    border-radius: 8px;
    padding: 15px 20px;
    margin-bottom: 30px;
    border: 1px solid #5a5a5a;
  }
  
  .secure-icon {
    width: 24px;
    height: 24px;
    color: #6a9aff; /* Blue for the lock icon */
    margin-right: 15px;
    flex-shrink: 0; /* Prevent icon from shrinking */
  }
  
  .secure-payment-info p {
    font-size: 0.85em;
    color: #b0b0b0;
    line-height: 1.4;
    margin: 0; /* Remove default paragraph margin */
  }
  
  .secure-text {
    color: #ffffff;
    font-weight: 600;
    display: block; /* Make it block to put "Your payment info..." on new line */
    margin-bottom: 4px;
  }
  
  .action-buttons {
    display: flex;
    flex-direction: column; /* Stack buttons vertically */
    gap: 15px;
  }
  
  .recharge-button,
  .cancel-button {
    width: 100%;
    padding: 15px;
    border: none;
    border-radius: 8px;
    font-size: 1.1em;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.2s ease, transform 0.1s ease;
  }
  
  .recharge-button {
    background-color: #6a9aff; /* Blue button */
    color: #ffffff;
  }
  
  .recharge-button:hover {
    background-color: #5a88e0;
    transform: translateY(-1px);
  }
  
  .cancel-button {
    background-color: transparent;
    color: #909090;
    border: 1px solid #5a5a5a;
  }
  
  .cancel-button:hover {
    background-color: #3a3a3a;
    transform: translateY(-1px);
  }
  </style>