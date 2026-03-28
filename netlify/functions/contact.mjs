/**
 * Netlify function: receives contact form submissions and creates
 * a person record in Clarify CRM.
 *
 * Requires CLARIFY_API_KEY environment variable set in Netlify dashboard.
 */

const CLARIFY_API_URL = 'https://api.getclarify.ai/v1';

export async function handler(event) {
  // Only allow POST
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: JSON.stringify({ error: 'Method not allowed' }) };
  }

  // Parse body
  let data;
  try {
    data = JSON.parse(event.body);
  } catch {
    return { statusCode: 400, body: JSON.stringify({ error: 'Invalid JSON' }) };
  }

  const { name, email, company, message } = data;

  if (!name || !email) {
    return { statusCode: 400, body: JSON.stringify({ error: 'Name and email are required' }) };
  }

  const apiKey = process.env.CLARIFY_API_KEY;
  if (!apiKey) {
    console.error('CLARIFY_API_KEY not set');
    return { statusCode: 500, body: JSON.stringify({ error: 'Server configuration error' }) };
  }

  // Split name into first/last
  const nameParts = name.trim().split(/\s+/);
  const firstName = nameParts[0] || '';
  const lastName = nameParts.slice(1).join(' ') || '';

  // Build description from message and company
  const descParts = [];
  if (company) descParts.push(`Company: ${company}`);
  if (message) descParts.push(`What they're building: ${message}`);
  const description = descParts.join('\n\n') || undefined;

  // Create person record in Clarify
  try {
    const response = await fetch(`${CLARIFY_API_URL}/persons`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${apiKey}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        attributes: {
          name: { first_name: firstName, last_name: lastName },
          email_addresses: { items: [[email]] },
          description,
          entity_type: { items: ['Prospect'] },
          lead_status: 'New',
          labels: { items: ['Inbound'] },
          contact_status: 'New contact',
        },
      }),
    });

    if (!response.ok) {
      const errorText = await response.text();
      console.error('Clarify API error:', response.status, errorText);
      // Still return success to user — form was captured by Netlify as fallback
      return {
        statusCode: 200,
        body: JSON.stringify({ success: true, clarify: false }),
      };
    }

    return {
      statusCode: 200,
      body: JSON.stringify({ success: true, clarify: true }),
    };
  } catch (err) {
    console.error('Clarify API request failed:', err);
    // Still return success — Netlify form captures as backup
    return {
      statusCode: 200,
      body: JSON.stringify({ success: true, clarify: false }),
    };
  }
}
